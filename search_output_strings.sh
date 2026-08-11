#!/usr/bin/env bash

set -euo pipefail

# Exhaustively enumerate distinct O/success traces for the puzzle's normal
# serial protocol, then recover one concrete 121-bit input for every trace.
#
# Usage:
#   ./search_output_strings.sh [dut.v] [result-directory]
#
# Optional environment overrides:
#   TOP_MODULE=puzzle MAX_MODELS=32 OBSERVE_STEPS=74 VERIFY_SIM=1
#   RESET_EDGES=3 IDLE_EDGES=1

DUT_FILE=${1:-puzzle_compact.v}
RESULT_DIR=${2:-output_search_results}
TOP_MODULE=${TOP_MODULE:-puzzle}
MAX_MODELS=${MAX_MODELS:-32}
OBSERVE_STEPS=${OBSERVE_STEPS:-74}
VERIFY_SIM=${VERIFY_SIM:-1}
RESET_EDGES=${RESET_EDGES:-3}
IDLE_EDGES=${IDLE_EDGES:-1}

CAPTURE_BITS=121
FIRST_CAPTURE_STEP=$((RESET_EDGES + IDLE_EDGES + 1))
LAST_CAPTURE_STEP=$((FIRST_CAPTURE_STEP + CAPTURE_BITS - 1))
RESULT_STEP=$((LAST_CAPTURE_STEP + 1))
OUTPUT_START_STEP=$((RESULT_STEP + 1))
SEQUENCE_STEPS=$((OUTPUT_START_STEP + OBSERVE_STEPS - 1))

if ! command -v yosys >/dev/null 2>&1; then
    echo "error: yosys is not installed or not on PATH" >&2
    exit 1
fi

if [[ ! -f "$DUT_FILE" ]]; then
    echo "error: DUT file not found: $DUT_FILE" >&2
    exit 1
fi

if (( MAX_MODELS < 1 )); then
    echo "error: MAX_MODELS must be positive" >&2
    exit 1
fi

# A 4-bit output counter has at most 16 positions. Observing at least 17
# positions proves that no later part of its cycle contains another message.
if (( OBSERVE_STEPS < 17 )); then
    echo "error: OBSERVE_STEPS must be at least 17" >&2
    exit 1
fi

mkdir -p -- "$RESULT_DIR"
DUT_ABS=$(realpath "$DUT_FILE")
RESULT_ABS=$(realpath "$RESULT_DIR")
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ENUM_LOG="$RESULT_ABS/enumeration.log"
TRACE_FILE="$RESULT_ABS/traces.tsv"
SUMMARY_FILE="$RESULT_ABS/summary.txt"

BASE_CONSTRAINTS='-set rst_n 1 -set enable 0'

for ((STEP_NUM = 1; STEP_NUM <= RESET_EDGES; STEP_NUM++)); do
    BASE_CONSTRAINTS+=" -set-at $STEP_NUM rst_n 0"
done

for ((STEP_NUM = FIRST_CAPTURE_STEP;
      STEP_NUM <= LAST_CAPTURE_STEP;
      STEP_NUM++)); do
    BASE_CONSTRAINTS+=" -set-at $STEP_NUM enable 1"
done

# Prevent irrelevant I values before and after capture from creating duplicate
# SAT models. The 121 captured values remain completely unconstrained.
for ((STEP_NUM = 1; STEP_NUM < FIRST_CAPTURE_STEP; STEP_NUM++)); do
    BASE_CONSTRAINTS+=" -set-at $STEP_NUM I 0"
done
for ((STEP_NUM = RESULT_STEP; STEP_NUM <= SEQUENCE_STEPS; STEP_NUM++)); do
    BASE_CONSTRAINTS+=" -set-at $STEP_NUM I 0"
done

YOSYS_PREP="read_verilog \"$DUT_ABS\"; prep -top $TOP_MODULE; async2sync; opt_clean"
ENUM_COMMAND="sat -seq $SEQUENCE_STEPS -set-init-zero -max $MAX_MODELS $BASE_CONSTRAINTS -show O -show success"

echo "Enumerating projected O/success traces..."
echo "  DUT:             $DUT_ABS"
echo "  reset steps:     1..$RESET_EDGES"
echo "  capture steps:   $FIRST_CAPTURE_STEP..$LAST_CAPTURE_STEP ($CAPTURE_BITS bits)"
echo "  output steps:    $OUTPUT_START_STEP..$SEQUENCE_STEPS ($OBSERVE_STEPS samples)"

yosys -Q -p "$YOSYS_PREP; $ENUM_COMMAND" >"$ENUM_LOG" 2>&1

if ! grep -q 'no more models found' "$ENUM_LOG"; then
    echo "error: enumeration did not exhaust the search" >&2
    echo "increase MAX_MODELS (currently $MAX_MODELS) and run again" >&2
    exit 1
fi

# One TSV row per projected model:
#   model-id, success-bit-vector, output-hex-vector, printable message
awk -v first="$OUTPUT_START_STEP" -v last="$SEQUENCE_STEPS" '
function emit_model() {
    if (model == 0)
        return
    printf "%d\t%s\t%s\t%s\n", model, success_bits, output_hex, message
}

/SAT solving finished - model found/ {
    emit_model()
    model++
    success_bits = ""
    output_hex = ""
    message = ""
    terminated = 0
    next
}

$2 == "\\O" {
    step = $1 + 0
    if (step >= first && step <= last) {
        value = $3 + 0
        output_hex = output_hex sprintf("%02x", value)
        if (!terminated) {
            if (value == 0) {
                terminated = 1
            } else if (value >= 32 && value <= 126) {
                message = message sprintf("%c", value)
            } else {
                message = message "?"
            }
        }
    }
}

$2 == "\\success" {
    step = $1 + 0
    if (step >= first && step <= last)
        success_bits = success_bits $3
}

END {
    emit_model()
}
' "$ENUM_LOG" >"$TRACE_FILE"

TRACE_COUNT=$(wc -l <"$TRACE_FILE")
if (( TRACE_COUNT == 0 )); then
    echo "error: no output traces were parsed from $ENUM_LOG" >&2
    exit 1
fi

SIM_VERIFY_ACTIVE=0
if [[ "$VERIFY_SIM" == "1" ]]; then
    if ! command -v iverilog >/dev/null 2>&1 || ! command -v vvp >/dev/null 2>&1; then
        echo "warning: iverilog/vvp unavailable; skipping concrete simulation" >&2
    elif [[ ! -f "$SCRIPT_DIR/tb_output_candidate.sv" ]]; then
        echo "warning: tb_output_candidate.sv unavailable; skipping concrete simulation" >&2
    else
        SIM_EXE="$RESULT_ABS/output_candidate.vvp"
        SIM_COMPILE_LOG="$RESULT_ABS/iverilog.log"
        if ! iverilog -g2012 -s tb_output_candidate \
            -o "$SIM_EXE" "$DUT_ABS" "$SCRIPT_DIR/tb_output_candidate.sv" \
            >"$SIM_COMPILE_LOG" 2>&1; then
            echo "error: Icarus compilation failed; see $SIM_COMPILE_LOG" >&2
            exit 1
        fi
        SIM_VERIFY_ACTIVE=1
    fi
fi

{
    echo "Exhaustive puzzle output search"
    echo "DUT: $DUT_ABS"
    echo "Capture bits: $CAPTURE_BITS"
    echo "Observation samples: $OBSERVE_STEPS"
    echo "Distinct traces: $TRACE_COUNT"
    echo "Concrete simulation enabled: $SIM_VERIFY_ACTIVE"
    echo
} >"$SUMMARY_FILE"

while IFS=$'\t' read -r MODEL_ID SUCCESS_BITS OUTPUT_HEX MESSAGE; do
    MODEL_PREFIX="$RESULT_ABS/model_$MODEL_ID"
    MODEL_LOG="$MODEL_PREFIX.log"
    MODEL_VCD="$MODEL_PREFIX.vcd"
    MODEL_BITS_FILE="$MODEL_PREFIX.bits"
    MODEL_GRID_FILE="$MODEL_PREFIX.grid"
    MODEL_SIM_LOG="$MODEL_PREFIX.sim.log"
    MODEL_SIM_VCD="$MODEL_PREFIX.sim.vcd"
    TRACE_CONSTRAINTS=''

    for ((TRACE_INDEX = 0; TRACE_INDEX < OBSERVE_STEPS; TRACE_INDEX++)); do
        STEP_NUM=$((OUTPUT_START_STEP + TRACE_INDEX))
        HEX_BYTE=${OUTPUT_HEX:$((TRACE_INDEX * 2)):2}
        BYTE_VALUE=$((16#$HEX_BYTE))
        SUCCESS_VALUE=${SUCCESS_BITS:$TRACE_INDEX:1}
        TRACE_CONSTRAINTS+=" -set-at $STEP_NUM O $BYTE_VALUE"
        TRACE_CONSTRAINTS+=" -set-at $STEP_NUM success $SUCCESS_VALUE"
    done

    RECOVER_COMMAND="sat -seq $SEQUENCE_STEPS -set-init-zero $BASE_CONSTRAINTS $TRACE_CONSTRAINTS -show I -show O -show success -dump_vcd \"$MODEL_VCD\""
    yosys -Q -p "$YOSYS_PREP; $RECOVER_COMMAND" >"$MODEL_LOG" 2>&1

    if ! grep -q 'SAT solving finished - model found' "$MODEL_LOG"; then
        echo "error: could not recover an input for model $MODEL_ID" >&2
        exit 1
    fi

    INPUT_BITS=$(awk -v first="$FIRST_CAPTURE_STEP" -v last="$LAST_CAPTURE_STEP" '
        $2 == "\\I" {
            step = $1 + 0
            if (step >= first && step <= last)
                printf "%s", $5
        }
    ' "$MODEL_LOG")

    if (( ${#INPUT_BITS} != CAPTURE_BITS )); then
        echo "error: model $MODEL_ID produced ${#INPUT_BITS} input bits, expected $CAPTURE_BITS" >&2
        exit 1
    fi

    printf '%s\n' "$INPUT_BITS" >"$MODEL_BITS_FILE"
    : >"$MODEL_GRID_FILE"
    for ((ROW_NUM = 0; ROW_NUM < 11; ROW_NUM++)); do
        printf '%s\n' "${INPUT_BITS:$((ROW_NUM * 11)):11}" >>"$MODEL_GRID_FILE"
    done

    SIM_STATUS='not requested'
    if (( SIM_VERIFY_ACTIVE == 1 )); then
        vvp "$SIM_EXE" \
            "+BITS=$INPUT_BITS" \
            "+SAMPLES=$OBSERVE_STEPS" \
            "+VCD=$MODEL_SIM_VCD" >"$MODEL_SIM_LOG" 2>&1
        SIM_OUTPUT_HEX=$(sed -n 's/^TRACE_HEX=//p' "$MODEL_SIM_LOG")
        SIM_SUCCESS=$(sed -n 's/^SUCCESS=//p' "$MODEL_SIM_LOG")
        SUCCESS_AT_START=${SUCCESS_BITS:0:1}
        if [[ "$SIM_OUTPUT_HEX" != "$OUTPUT_HEX" ||
              "$SIM_SUCCESS" != "$SUCCESS_AT_START" ]]; then
            echo "error: concrete simulation mismatch for model $MODEL_ID" >&2
            echo "formal O=$OUTPUT_HEX success=$SUCCESS_AT_START" >&2
            echo "sim    O=$SIM_OUTPUT_HEX success=$SIM_SUCCESS" >&2
            exit 1
        fi
        SIM_STATUS='verified'
    fi

    SUCCESS_AT_START=${SUCCESS_BITS:0:1}
    {
        printf 'model %d\n' "$MODEL_ID"
        printf 'message: %s\n' "$MESSAGE"
        printf 'success: %s\n' "$SUCCESS_AT_START"
        printf 'simulation: %s\n' "$SIM_STATUS"
        printf 'input: %s\n' "$INPUT_BITS"
        echo 'grid:'
        sed 's/^/  /' "$MODEL_GRID_FILE"
        echo
    } | tee -a "$SUMMARY_FILE"
done <"$TRACE_FILE"

echo "Search exhausted after $TRACE_COUNT distinct projected traces."
echo "Summary: $SUMMARY_FILE"
echo "Logs, representative inputs, grids, and VCDs: $RESULT_ABS"
