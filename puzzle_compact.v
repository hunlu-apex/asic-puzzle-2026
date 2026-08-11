// Extracted from GDS via Magic

module puzzle (
    input  wire       I,
    input  wire       clk,
    input  wire       enable,
    input  wire       rst_n,
    output wire [7:0] O,
    output wire       success
);

wire VPWR = 1'b1;
wire VGND = 1'b0;

wire n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442, n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453, n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464, n465, n466, n467, n468, n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, n479, n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490, n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501, n502, n503, n504, n505, n506, n507, n508, n509, n510, n511, n512, n513, n514, n515, n516, n517, n518, n519, n520, n521, n522, n523, n524, n525, n526, n527, n528, n529, n530, n531, n532, n533, n534, n535, n536, n537, n538, n539, n540, n541, n542, n543, n544, n545, n546, n547, n548, n549, n550, n551, n552, n553, n554, n555, n556, n557, n558, n559, n560, n561, n562, n563, n564, n565, n566, n567, n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583, n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605, n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616, n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627, n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638, n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649, n650, n651, n652, n653, n654, n655, n656, n657, n658, n659, n660, n661, n662, n663, n664, n665, n666, n667, n668, n669, n670, n671, n672, n673, n674, n675, n676, n677, n678, n679, n680, n681, n682, n683, n684, n685, n686, n687, n688, n689, n690, n691, n692, n693, n694, n695, n696, n697, n698, n699, n700, n701, n702, n703, n704, n705, n706, n707, n708, n709, n710, n711, n712, n713, n714, n715, n716, n717, n718, n719, n720, n721, n722, n723, n724, n725, n726, n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737, n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748, n749, n750, n751, n752;

// Recovered state registers
reg n173_reg;
reg n206_reg;
reg success_reg;
reg n91_reg;
reg n116_reg;
reg n134_reg;
reg n271_reg;
reg n204_reg;
reg n23_reg;
reg n275_reg;
reg n299_reg;
reg n241_reg;
reg n99_reg;
reg n302_reg;
reg n338_reg;
reg n211_reg;
reg n342_reg;
reg n27_reg;
reg n345_reg;
reg n35_reg;
reg n379_reg;
reg n381_reg;
reg n383_reg;
reg n386_reg;
reg n388_reg;
reg n366_reg;
reg n33_reg;
reg n65_reg;
reg n240_reg;
reg n413_reg;
reg n415_reg;
reg n417_reg;
reg n217_reg;
reg n11_reg;
reg n449_reg;
reg n451_reg;
reg n453_reg;
reg n448_reg;
reg n66_reg;
reg n6_reg;
reg n218_reg;
reg n81_reg;
reg n212_reg;
reg n490_reg;
reg n19_reg;
reg n62_reg;
reg n493_reg;
reg n73_reg;
reg n142_reg;
reg n309_reg;
reg n526_reg;
reg n521_reg;
reg n530_reg;
reg n63_reg;
reg n532_reg;
reg n68_reg;
reg n140_reg;
reg n261_reg;
reg n231_reg;
reg n447_reg;
reg n480_reg;
reg n459_reg;
reg n8_reg;
reg n136_reg;
reg n203_reg;
reg n550_reg;
reg n487_reg;
reg n347_reg;
reg n108_reg;
reg n101_reg;
reg n599_reg;
reg n601_reg;
reg n612_reg;
reg n114_reg;
reg n615_reg;
reg n113_reg;
reg n176_reg;
reg n41_reg;
reg n222_reg;
reg n38_reg;
reg n638_reg;
reg n169_reg;
reg n540_reg;
reg n267_reg;
reg n278_reg;
reg n352_reg;
reg n404_reg;
reg n82_reg;
reg n12_reg;
reg n566_reg;
reg n696_reg;
reg n586_reg;

// Recovered logic

assign n2 = ~(n0 | n1 | n3 | n4); // Xsky130_fd_sc_hd__nor4_2_0 (nor4)
assign n7 = (n6_reg | n8_reg); // Xsky130_fd_sc_hd__or2_2_8 (or2)
assign n10 = (n11_reg & ~(n12_reg)); // Xsky130_fd_sc_hd__and2b_2_3 (and2b)
assign n14 = ~((n13 | n16 | n17) & (n15)); // Xsky130_fd_sc_hd__o31ai_2_1 (o31ai)
assign n18 = ((n19_reg) | (n20 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_17 (a31o)
assign O[3] = (n22 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_20 (and3)
assign n25 = ~(n21 & I & n26 & n27_reg); // Xsky130_fd_sc_hd__nand4_2_12 (nand4)
assign n30 = (n28 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_17 (or3)
assign n32 = ((n33_reg) | (n34 & n35_reg & n36)); // Xsky130_fd_sc_hd__a31o_2_9 (a31o)
assign n37 = ~(n38_reg ^ n39); // Xsky130_fd_sc_hd__xnor2_2_24 (xnor2)
assign n20 = (~(n3) & n0 & ~(n1) & n4); // Xsky130_fd_sc_hd__and4bb_2_7 (and4bb)
assign n40 = ~(n41_reg ^ n42); // Xsky130_fd_sc_hd__xnor2_2_13 (xnor2)
assign n43 = n44; // Xsky130_fd_sc_hd__clkbuf_8_15 (clkbuf)
assign n46 = ~(~(n45) | n47 | n48); // Xsky130_fd_sc_hd__nor3b_2_2 (nor3b)
assign n49 = n44; // Xsky130_fd_sc_hd__clkbuf_8_1 (clkbuf)
assign n53 = (n50 ? n51 : n52); // Xsky130_fd_sc_hd__mux2_1_4 (mux2)
assign n54 = ((n55) | (n56 & n57)); // Xsky130_fd_sc_hd__a21o_2_8 (a21o)
assign n61 = ~((n58 & n21) | (n59) | (n60)); // Xsky130_fd_sc_hd__a211oi_2_0 (a211oi)
assign n64 = ~(n62_reg | n63_reg | n65_reg | n66_reg); // Xsky130_fd_sc_hd__nor4_2_1 (nor4)
assign n72 = ~((n68_reg & n69) | (n70 & n71)); // Xsky130_fd_sc_hd__a22oi_2_0 (a22oi)
assign n70 = (n8_reg | n73_reg); // Xsky130_fd_sc_hd__or2_2_9 (or2)
assign n76 = ((n74 | n77) & (n75 | n79) & (n78)); // Xsky130_fd_sc_hd__o221a_2_0 (o221a)
assign n80 = (n81_reg & ~(n82_reg)); // Xsky130_fd_sc_hd__and2b_2_4 (and2b)
assign n84 = (n85 & n86 & n87 & n88); // Xsky130_fd_sc_hd__and4_2_0 (and4)
assign n90 = ((n91_reg) | (n64 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_18 (a31o)
assign n93 = (n92 & n94 & n95); // Xsky130_fd_sc_hd__and3_2_10 (and3)
assign O[4] = (n96 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_21 (and3)
assign n97 = ~(n21 & I & n98 & n99_reg); // Xsky130_fd_sc_hd__nand4_2_13 (nand4)
assign n100 = ~(n101_reg ^ n102); // Xsky130_fd_sc_hd__xnor2_2_25 (xnor2)
assign n103 = (~(n4) & n0 & ~(n1) & n3); // Xsky130_fd_sc_hd__and4bb_2_8 (and4bb)
assign n104 = ~(n38_reg ^ n105); // Xsky130_fd_sc_hd__xnor2_2_14 (xnor2)
assign n106 = ~(~(n48) | n47 | n45); // Xsky130_fd_sc_hd__nor3b_2_3 (nor3b)
assign n107 = n44; // Xsky130_fd_sc_hd__clkbuf_8_2 (clkbuf)
assign n111 = (n108_reg ? n109 : n110); // Xsky130_fd_sc_hd__mux2_1_5 (mux2)
assign n112 = ((n113_reg) | (n114_reg & n115)); // Xsky130_fd_sc_hd__a21o_2_9 (a21o)
assign n47 = ~((n116_reg & n118) | (n117) | (n93)); // Xsky130_fd_sc_hd__a211oi_2_1 (a211oi)
assign n121 = ((n119 | n122) & (n120 | n38_reg) & (n123)); // Xsky130_fd_sc_hd__o221a_2_1 (o221a)
assign n124 = (n125 & ~(n126)); // Xsky130_fd_sc_hd__and2b_2_5 (and2b)
assign n128 = ~((n74) | (n127 & n17)); // Xsky130_fd_sc_hd__a21oi_2_0 (a21oi)
assign n129 = (n130 & n10 & n131 & n80); // Xsky130_fd_sc_hd__and4_2_1 (and4)
assign n133 = ((n134_reg) | (n135 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_19 (a31o)
assign n137 = ((n113_reg) & (n114_reg) & (n136_reg | n108_reg)); // Xsky130_fd_sc_hd__o211a_2_0 (o211a)
assign O[5] = (n138 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_22 (and3)
assign n141 = (n140_reg & n142_reg & n36); // Xsky130_fd_sc_hd__and3_2_11 (and3)
assign n24 = ~(n8_reg & n6_reg & n68_reg & n73_reg); // Xsky130_fd_sc_hd__nand4_2_14 (nand4)
assign n143 = (~(n65_reg) & n63_reg & ~(n62_reg) & n66_reg); // Xsky130_fd_sc_hd__and4bb_2_9 (and4bb)
assign n144 = ~(n101_reg ^ n145); // Xsky130_fd_sc_hd__xnor2_2_15 (xnor2)
assign n146 = ~(n147 ^ n148); // Xsky130_fd_sc_hd__xnor2_2_26 (xnor2)
assign n29 = ~(~(n47) | n45 | n48); // Xsky130_fd_sc_hd__nor3b_2_4 (nor3b)
assign n149 = n44; // Xsky130_fd_sc_hd__clkbuf_8_3 (clkbuf)
assign n152 = (n150 ? n151 : n58); // Xsky130_fd_sc_hd__mux2_1_6 (mux2)
assign n28 = ~((n73_reg & n68_reg) | (n6_reg) | (n8_reg)); // Xsky130_fd_sc_hd__a211oi_2_2 (a211oi)
assign n155 = ((n153 | n156) & (n154 | n7) & (n157)); // Xsky130_fd_sc_hd__o221a_2_2 (o221a)
assign n158 = (n1 | n3 | n0 | ~(n4)); // Xsky130_fd_sc_hd__or4b_2_0 (or4b)
assign n159 = (n68_reg & ~(n8_reg)); // Xsky130_fd_sc_hd__and2b_2_6 (and2b)
assign n162 = ~((n160) | (n161 & n51)); // Xsky130_fd_sc_hd__a21oi_2_1 (a21oi)
assign n115 = (n136_reg & n58 & n21 & n108_reg); // Xsky130_fd_sc_hd__and4_2_2 (and4)
assign n163 = ((n15) & (n51) & (n16 | n13)); // Xsky130_fd_sc_hd__o211a_2_1 (o211a)
assign O[7] = (n164 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_23 (and3)
assign n166 = (n165 & n167 & n168); // Xsky130_fd_sc_hd__and3_2_12 (and3)
assign n148 = ~(n169_reg ^ n41_reg); // Xsky130_fd_sc_hd__xnor2_2_16 (xnor2)
assign n170 = ~(n6_reg ^ n171); // Xsky130_fd_sc_hd__xnor2_2_27 (xnor2)
assign n172 = n44; // Xsky130_fd_sc_hd__clkbuf_8_4 (clkbuf)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n173_reg <= 1'b0;
    else
        n173_reg <= n174;
end

assign n179 = (n176_reg ? n177 : n178); // Xsky130_fd_sc_hd__mux2_1_7 (mux2)
assign n180 = ((~(n63_reg) | ~(n181)) & (n114_reg | n182)); // Xsky130_fd_sc_hd__o2bb2a_2_0 (o2bb2a)
assign n183 = (n1 | n4 | n0 | ~(n3)); // Xsky130_fd_sc_hd__or4b_2_1 (or4b)
assign n184 = (n169_reg ^ n185); // Xsky130_fd_sc_hd__xor2_2_20 (xor2)
assign n186 = (n8_reg & ~(n73_reg)); // Xsky130_fd_sc_hd__and2b_2_7 (and2b)
assign n190 = ~((n74) | (n188 & n189)); // Xsky130_fd_sc_hd__a21oi_2_2 (a21oi)
assign n191 = (n35_reg & n142_reg & n140_reg & n192); // Xsky130_fd_sc_hd__and4_2_3 (and4)
assign n4 = ((n193) & (n194) & (n195 | n196)); // Xsky130_fd_sc_hd__o211a_2_2 (o211a)
assign O[2] = (n197 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_24 (and3)
assign n199 = (n198 & n200 & n166); // Xsky130_fd_sc_hd__and3_2_13 (and3)
assign n120 = (n21 | n201); // Xsky130_fd_sc_hd__or2_2_10 (or2)
assign n202 = ~(n73_reg ^ n68_reg); // Xsky130_fd_sc_hd__xnor2_2_28 (xnor2)
assign n147 = ~(n203_reg ^ n204_reg); // Xsky130_fd_sc_hd__xnor2_2_17 (xnor2)
assign n205 = n44; // Xsky130_fd_sc_hd__clkbuf_8_5 (clkbuf)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n206_reg <= 1'b0;
    else
        n206_reg <= n207;
end

assign success = success_reg; // Xsky130_fd_sc_hd__dfrtp_2_81
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        success_reg <= 1'b0;
    else
        success_reg <= n209;
end

assign n213 = (n21 ? n211_reg : n212_reg); // Xsky130_fd_sc_hd__mux2_1_8 (mux2)
assign n214 = (n0 | n3 | n4 | ~(n1)); // Xsky130_fd_sc_hd__or4b_2_2 (or4b)
assign n215 = (n217_reg ^ n216); // Xsky130_fd_sc_hd__xor2_2_10 (xor2)
assign n92 = (n218_reg & ~(n142_reg)); // Xsky130_fd_sc_hd__and2b_2_8 (and2b)
assign n221 = ~((n78) | (n219 & n220)); // Xsky130_fd_sc_hd__a21oi_2_3 (a21oi)
assign n216 = (n36 & n222_reg & n95 & n34); // Xsky130_fd_sc_hd__and4_2_4 (and4)
assign n50 = ~(n223 & ~(n161)); // Xsky130_fd_sc_hd__nand2b_2_0 (nand2b)
assign n3 = ((n194) & (n224) & (n225 | n226)); // Xsky130_fd_sc_hd__o211a_2_3 (o211a)
assign O[0] = (n227 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_25 (and3)
assign n59 = (n66_reg & n65_reg & n21); // Xsky130_fd_sc_hd__and3_2_14 (and3)
assign n224 = ~((n189 | n228) & (n229) & (n226)); // Xsky130_fd_sc_hd__o211ai_2_0 (o211ai)
assign n230 = (n23_reg | n231_reg); // Xsky130_fd_sc_hd__or2_2_11 (or2)
assign n232 = ~(n233 ^ n234); // Xsky130_fd_sc_hd__xnor2_2_18 (xnor2)
assign n235 = n44; // Xsky130_fd_sc_hd__clkbuf_8_6 (clkbuf)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n91_reg <= 1'b0;
    else
        n91_reg <= n236;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n116_reg <= 1'b0;
    else
        n116_reg <= n238;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n134_reg <= 1'b0;
    else
        n134_reg <= n239;
end

assign n242 = (n21 ? n240_reg : n241_reg); // Xsky130_fd_sc_hd__mux2_1_9 (mux2)
assign n244 = (n243 | n74 | n78 | n245); // Xsky130_fd_sc_hd__or4_2_0 (or4)
assign n246 = (n1 | n3 | n4 | ~(n0)); // Xsky130_fd_sc_hd__or4b_2_3 (or4b)
assign n247 = (n63_reg ^ n59); // Xsky130_fd_sc_hd__xor2_2_11 (xor2)
assign n248 = (n249 & ~(n216)); // Xsky130_fd_sc_hd__and2b_2_9 (and2b)
assign n250 = n49; // Xsky130_fd_sc_hd__clkbuf_4_0 (clkbuf)
assign n254 = ~((n251) | (n252 & n253)); // Xsky130_fd_sc_hd__a21oi_2_4 (a21oi)
assign n200 = (n255 & n256 & n257 & n258); // Xsky130_fd_sc_hd__and4_2_5 (and4)
assign n260 = ~(n259 & ~(n261_reg)); // Xsky130_fd_sc_hd__nand2b_2_1 (nand2b)
assign n1 = ((n194) & (n262) & (n263 | n226)); // Xsky130_fd_sc_hd__o211a_2_4 (o211a)
assign n264 = (n73_reg & n68_reg & n8_reg); // Xsky130_fd_sc_hd__and3_2_15 (and3)
assign n266 = (n265 | n267_reg); // Xsky130_fd_sc_hd__or2_2_12 (or2)
assign n268 = ~(n269 ^ n39); // Xsky130_fd_sc_hd__xnor2_2_19 (xnor2)
assign n270 = n44; // Xsky130_fd_sc_hd__clkbuf_8_7 (clkbuf)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n271_reg <= 1'b0;
    else
        n271_reg <= n272;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n204_reg <= 1'b0;
    else
        n204_reg <= n274;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n23_reg <= 1'b0;
    else
        n23_reg <= n230;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n275_reg <= 1'b0;
    else
        n275_reg <= n276;
end

assign n277 = ~(n275_reg); // Xsky130_fd_sc_hd__inv_2_20 (inv)
assign n279 = (n158 | n278_reg | n280 | n281); // Xsky130_fd_sc_hd__or4_2_1 (or4)
assign n282 = (n63_reg | n65_reg | n62_reg | ~(n66_reg)); // Xsky130_fd_sc_hd__or4b_2_4 (or4b)
assign n283 = (n203_reg ^ n284); // Xsky130_fd_sc_hd__xor2_2_12 (xor2)
assign n285 = n286; // Xsky130_fd_sc_hd__clkbuf_4_1 (clkbuf)
assign n287 = ~((n114_reg) | (n113_reg & n136_reg)); // Xsky130_fd_sc_hd__a21oi_2_5 (a21oi)
assign n198 = (n288 & n289 & n290 & n291); // Xsky130_fd_sc_hd__and4_2_6 (and4)
assign n293 = ~(n292 & ~(n11_reg)); // Xsky130_fd_sc_hd__nand2b_2_2 (nand2b)
assign n0 = ((n194) & (n294) & (n295 | n226)); // Xsky130_fd_sc_hd__o211a_2_5 (o211a)
assign n298 = ~((n62_reg & n297) | (n296) | (n58 & n21)); // Xsky130_fd_sc_hd__a221oi_2_0 (a221oi)
assign n171 = (n73_reg & n68_reg & n8_reg); // Xsky130_fd_sc_hd__and3_2_16 (and3)
assign n237 = n44; // Xsky130_fd_sc_hd__clkbuf_8_8 (clkbuf)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n299_reg <= 1'b0;
    else
        n299_reg <= n300;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n241_reg <= 1'b0;
    else
        n241_reg <= n242;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n99_reg <= 1'b0;
    else
        n99_reg <= n301;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n302_reg <= 1'b0;
    else
        n302_reg <= n303;
end

assign n304 = ~(n6_reg); // Xsky130_fd_sc_hd__inv_2_21 (inv)
assign n305 = ~(n36); // Xsky130_fd_sc_hd__inv_2_10 (inv)
assign n306 = ~(n307 & n308); // Xsky130_fd_sc_hd__nand2_2_0 (nand2)
assign n310 = (n214 | n309_reg | n311 | n312); // Xsky130_fd_sc_hd__or4_2_2 (or4)
assign n313 = (n62_reg | n65_reg | n66_reg | ~(n63_reg)); // Xsky130_fd_sc_hd__or4b_2_5 (or4b)
assign n314 = (n267_reg ^ n299_reg); // Xsky130_fd_sc_hd__xor2_2_13 (xor2)
assign n135 = (~(n62_reg) & n66_reg & ~(n63_reg) & n65_reg); // Xsky130_fd_sc_hd__and4bb_2_10 (and4bb)
assign n315 = n172; // Xsky130_fd_sc_hd__clkbuf_4_2 (clkbuf)
assign n318 = ~((n316) | (n317 & n113_reg)); // Xsky130_fd_sc_hd__a21oi_2_6 (a21oi)
assign n297 = (n63_reg & n65_reg & n66_reg & n21); // Xsky130_fd_sc_hd__and4_2_7 (and4)
assign n320 = ~(n319 & ~(n81_reg)); // Xsky130_fd_sc_hd__nand2b_2_3 (nand2b)
assign n322 = ((n321) & (n78) & (n52 | n220)); // Xsky130_fd_sc_hd__o211a_2_6 (o211a)
assign n324 = (n323 & n68_reg & n325); // Xsky130_fd_sc_hd__and3_2_17 (and3)
assign n327 = ((~(n128)) | (n326 & n308)); // Xsky130_fd_sc_hd__a21bo_2_0 (a21bo)
assign n330 = ~((n328 & n331 & n332) | (n329)); // Xsky130_fd_sc_hd__a31oi_2_0 (a31oi)
assign n196 = ((n74 | n333 | n334) & (n78) & (n335)); // Xsky130_fd_sc_hd__o311a_2_0 (o311a)
assign n181 = ~((n336) | (n337 & n136_reg)); // Xsky130_fd_sc_hd__a21oi_2_10 (a21oi)
assign n175 = n44; // Xsky130_fd_sc_hd__clkbuf_8_9 (clkbuf)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n338_reg <= 1'b0;
    else
        n338_reg <= n339;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n211_reg <= 1'b0;
    else
        n211_reg <= n341;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n342_reg <= 1'b0;
    else
        n342_reg <= n343;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n27_reg <= 1'b0;
    else
        n27_reg <= n344;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n345_reg <= 1'b0;
    else
        n345_reg <= n346;
end

assign n348 = ~(n347_reg); // Xsky130_fd_sc_hd__inv_2_11 (inv)
assign n118 = ~(success_reg); // Xsky130_fd_sc_hd__inv_2_22 (inv)
assign n349 = ~(n350 & n351); // Xsky130_fd_sc_hd__nand2_2_1 (nand2)
assign n353 = (n183 | n352_reg | n354 | n355); // Xsky130_fd_sc_hd__or4_2_3 (or4)
assign n358 = ((n356 | n357) & (n162 | n333 | n74)); // Xsky130_fd_sc_hd__o32a_2_0 (o32a)
assign n359 = (n63_reg | n66_reg | n62_reg | ~(n65_reg)); // Xsky130_fd_sc_hd__or4b_2_6 (or4b)
assign n360 = (n38_reg ^ n203_reg); // Xsky130_fd_sc_hd__xor2_2_14 (xor2)
assign n26 = (~(n65_reg) & n62_reg & ~(n63_reg) & n66_reg); // Xsky130_fd_sc_hd__and4bb_2_11 (and4bb)
assign n361 = n149; // Xsky130_fd_sc_hd__clkbuf_4_3 (clkbuf)
assign n363 = ~((n126) | (n125 & n362)); // Xsky130_fd_sc_hd__a21oi_2_7 (a21oi)
assign n365 = ~(n364 & ~(n366_reg)); // Xsky130_fd_sc_hd__nand2b_2_4 (nand2b)
assign n370 = ((n367) & (n368) & (n109 | n369)); // Xsky130_fd_sc_hd__o211a_2_7 (o211a)
assign O[1] = (n371 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_18 (and3)
assign n374 = ((~(n372)) | (n373 & n74)); // Xsky130_fd_sc_hd__a21bo_2_1 (a21bo)
assign n375 = ((n369 | n109 | n108_reg) & (n376) & (n112)); // Xsky130_fd_sc_hd__o311a_2_1 (o311a)
assign n377 = ~((n218_reg) | (n21 & I)); // Xsky130_fd_sc_hd__a21oi_2_11 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n35_reg <= 1'b0;
    else
        n35_reg <= n378;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n379_reg <= 1'b0;
    else
        n379_reg <= n380;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n381_reg <= 1'b0;
    else
        n381_reg <= n382;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n383_reg <= 1'b0;
    else
        n383_reg <= n384;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n386_reg <= 1'b0;
    else
        n386_reg <= n387;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n388_reg <= 1'b0;
    else
        n388_reg <= n389;
end

assign n392 = ~(n391); // Xsky130_fd_sc_hd__inv_2_12 (inv)
assign n393 = ~(n348); // Xsky130_fd_sc_hd__inv_2_23 (inv)
assign n182 = ~(n108_reg & n136_reg); // Xsky130_fd_sc_hd__nand2_2_2 (nand2)
assign n394 = (n63_reg | n66_reg | n65_reg | n62_reg); // Xsky130_fd_sc_hd__or4_2_4 (or4)
assign n397 = ((n395 | n356) & (n396 | n333 | n74)); // Xsky130_fd_sc_hd__o32a_2_1 (o32a)
assign n398 = (n63_reg | n65_reg | n66_reg | ~(n62_reg)); // Xsky130_fd_sc_hd__or4b_2_7 (or4b)
assign n234 = (n299_reg ^ n70); // Xsky130_fd_sc_hd__xor2_2_15 (xor2)
assign n399 = ~((~(n21)) | (n146 & I)); // Xsky130_fd_sc_hd__a21boi_2_0 (a21boi)
assign n98 = (~(n66_reg) & n62_reg & ~(n63_reg) & n65_reg); // Xsky130_fd_sc_hd__and4bb_2_12 (and4bb)
assign n401 = n107; // Xsky130_fd_sc_hd__clkbuf_4_4 (clkbuf)
assign n329 = ~((n6_reg) | (n73_reg & n68_reg)); // Xsky130_fd_sc_hd__a21oi_2_8 (a21oi)
assign n403 = ~(n402 & ~(n404_reg)); // Xsky130_fd_sc_hd__nand2b_2_5 (nand2b)
assign n405 = ((n21) & (n177) & (n178 | n176_reg)); // Xsky130_fd_sc_hd__o211a_2_8 (o211a)
assign O[6] = (n406 & n23_reg & n24); // Xsky130_fd_sc_hd__and3_2_19 (and3)
assign n407 = ((n50 | n17) & (n408 | n409)); // Xsky130_fd_sc_hd__o22a_2_0 (o22a)
assign n130 = (n366_reg & ~(n388_reg)); // Xsky130_fd_sc_hd__and2b_2_20 (and2b)
assign n410 = ~((n152) | (n178 & n151)); // Xsky130_fd_sc_hd__a21oi_2_12 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n366_reg <= 1'b0;
    else
        n366_reg <= n365;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n33_reg <= 1'b0;
    else
        n33_reg <= n411;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n65_reg <= 1'b0;
    else
        n65_reg <= n61;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n240_reg <= 1'b0;
    else
        n240_reg <= n412;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n413_reg <= 1'b0;
    else
        n413_reg <= n414;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n415_reg <= 1'b0;
    else
        n415_reg <= n416;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n417_reg <= 1'b0;
    else
        n417_reg <= n418;
end

assign n48 = ~(n419); // Xsky130_fd_sc_hd__inv_2_24 (inv)
assign n69 = ~(n6_reg); // Xsky130_fd_sc_hd__inv_2_13 (inv)
assign n220 = ~(n74 & n420); // Xsky130_fd_sc_hd__nand2_2_3 (nand2)
assign n421 = (n246 | n338_reg | n422 | n423); // Xsky130_fd_sc_hd__or4_2_5 (or4)
assign n424 = (~(n6_reg) & n68_reg & n73_reg & n8_reg); // Xsky130_fd_sc_hd__and4b_2_0 (and4b)
assign n425 = ~(n8_reg | n68_reg | n73_reg); // Xsky130_fd_sc_hd__nor3_2_0 (nor3)
assign n429 = ((n426 | n427) & (n428 | n170 | n392)); // Xsky130_fd_sc_hd__o32a_2_2 (o32a)
assign n419 = (n93 | n117 | success_reg | ~(n116_reg)); // Xsky130_fd_sc_hd__or4b_2_8 (or4b)
assign n430 = (n38_reg ^ n265); // Xsky130_fd_sc_hd__xor2_2_16 (xor2)
assign n431 = ~((~(n23_reg)) | (n202 & n24)); // Xsky130_fd_sc_hd__a21boi_2_1 (a21boi)
assign n432 = (~(n66_reg) & n63_reg & ~(n62_reg) & n65_reg); // Xsky130_fd_sc_hd__and4bb_2_13 (and4bb)
assign n433 = n205; // Xsky130_fd_sc_hd__clkbuf_4_5 (clkbuf)
assign n434 = ~((n6_reg) | (n73_reg & n68_reg)); // Xsky130_fd_sc_hd__a21oi_2_9 (a21oi)
assign n253 = ~(n435 & ~(n317)); // Xsky130_fd_sc_hd__nand2b_2_6 (nand2b)
assign n438 = ((n436) & (n437) & (n7 | n73_reg)); // Xsky130_fd_sc_hd__o211a_2_9 (o211a)
assign n262 = ((n439 & n190) | (n74 & n440) | (n441)); // Xsky130_fd_sc_hd__a221o_2_0 (a221o)
assign n442 = ((n8_reg | n73_reg) & (n434 | n424)); // Xsky130_fd_sc_hd__o22a_2_1 (o22a)
assign n389 = ((n366_reg | n364) & (n443)); // Xsky130_fd_sc_hd__o21a_2_30 (o21a)
assign n444 = (n445 & ~(n141)); // Xsky130_fd_sc_hd__and2b_2_10 (and2b)
assign n446 = (n447_reg & ~(n448_reg)); // Xsky130_fd_sc_hd__and2b_2_21 (and2b)
assign n60 = ~((n65_reg) | (n21 & n66_reg)); // Xsky130_fd_sc_hd__a21oi_2_13 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n217_reg <= 1'b0;
    else
        n217_reg <= n215;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n11_reg <= 1'b0;
    else
        n11_reg <= n293;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n449_reg <= 1'b0;
    else
        n449_reg <= n450;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n451_reg <= 1'b0;
    else
        n451_reg <= n452;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n453_reg <= 1'b0;
    else
        n453_reg <= n454;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n448_reg <= 1'b0;
    else
        n448_reg <= n455;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n66_reg <= 1'b0;
    else
        n66_reg <= n456;
end

assign n323 = ~(n6_reg); // Xsky130_fd_sc_hd__inv_2_14 (inv)
assign n458 = ~(n66_reg & n108_reg); // Xsky130_fd_sc_hd__nand2_2_4 (nand2)
assign n460 = (n398 | n459_reg | n277 | n461); // Xsky130_fd_sc_hd__or4_2_6 (or4)
assign n462 = (~(n0) & n3 & n4 & n1); // Xsky130_fd_sc_hd__and4b_2_1 (and4b)
assign n463 = ~(n331 | n8_reg | n464); // Xsky130_fd_sc_hd__nor3_2_1 (nor3)
assign n468 = ((n120 | n267_reg) & (n465 | n466 | n467)); // Xsky130_fd_sc_hd__o32a_2_3 (o32a)
assign n102 = (n204_reg ^ n41_reg); // Xsky130_fd_sc_hd__xor2_2_17 (xor2)
assign n470 = ~((~(n23_reg)) | (n469 & n304)); // Xsky130_fd_sc_hd__a21boi_2_2 (a21boi)
assign n471 = n235; // Xsky130_fd_sc_hd__clkbuf_4_6 (clkbuf)
assign n333 = (n308 & n51 & n161); // Xsky130_fd_sc_hd__and3_2_0 (and3)
assign n472 = ~(n68_reg & ~(n8_reg)); // Xsky130_fd_sc_hd__nand2b_2_7 (nand2b)
assign n474 = ((n473 | n6_reg) & (n475 | n464)); // Xsky130_fd_sc_hd__o22a_2_2 (o22a)
assign n477 = ((n478 & n480_reg) | (n479 & n449_reg) | (n481)); // Xsky130_fd_sc_hd__a221o_2_1 (a221o)
assign n303 = ((n302_reg | n483) & (n482)); // Xsky130_fd_sc_hd__o21a_2_20 (o21a)
assign n484 = (n338_reg & n422); // Xsky130_fd_sc_hd__and2_2_10 (and2)
assign n21 = (enable & ~(n231_reg)); // Xsky130_fd_sc_hd__and2b_2_11 (and2b)
assign n486 = (n487_reg & ~(n19_reg)); // Xsky130_fd_sc_hd__and2b_2_22 (and2b)
assign n294 = ((n488 & n189) | (n76) | (n441)); // Xsky130_fd_sc_hd__a211o_2_0 (a211o)
always @(posedge clk) begin
    n6_reg <= n470;
end

assign n153 = ~((n8_reg) | (n6_reg & n68_reg)); // Xsky130_fd_sc_hd__a21oi_2_14 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n218_reg <= 1'b0;
    else
        n218_reg <= n489;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n81_reg <= 1'b0;
    else
        n81_reg <= n320;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n212_reg <= 1'b0;
    else
        n212_reg <= n213;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n490_reg <= 1'b0;
    else
        n490_reg <= n491;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n19_reg <= 1'b0;
    else
        n19_reg <= n492;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n62_reg <= 1'b0;
    else
        n62_reg <= n298;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n493_reg <= 1'b0;
    else
        n493_reg <= n494;
end

assign n495 = ~(n68_reg); // Xsky130_fd_sc_hd__inv_2_15 (inv)
assign n497 = ~(n308 & n498); // Xsky130_fd_sc_hd__nand2_2_5 (nand2)
assign n482 = (n359 | n453_reg | n499 | n500); // Xsky130_fd_sc_hd__or4_2_7 (or4)
assign n501 = (~(n62_reg) & n65_reg & n66_reg & n63_reg); // Xsky130_fd_sc_hd__and4b_2_2 (and4b)
assign n502 = n394; // Xsky130_fd_sc_hd__buf_2_0 (buf)
assign n504 = ~(n503); // Xsky130_fd_sc_hd__inv_2_0 (inv)
assign n192 = ~(n505 | n33_reg | n222_reg); // Xsky130_fd_sc_hd__nor3_2_2 (nor3)
assign n506 = (n204_reg ^ n429); // Xsky130_fd_sc_hd__xor2_2_18 (xor2)
assign n507 = ~((~(n23_reg)) | (n24 & n68_reg)); // Xsky130_fd_sc_hd__a21boi_2_3 (a21boi)
assign n509 = n270; // Xsky130_fd_sc_hd__clkbuf_4_7 (clkbuf)
assign n511 = (n510 & n51 & n306); // Xsky130_fd_sc_hd__and3_2_1 (and3)
assign n328 = ~(n8_reg & ~(n6_reg)); // Xsky130_fd_sc_hd__nand2b_2_8 (nand2b)
assign n274 = ((n120 | n204_reg) & (n512 | n513)); // Xsky130_fd_sc_hd__o22a_2_3 (o22a)
assign n300 = ((n299_reg & n514) | (n21 & n38_reg) | (n515)); // Xsky130_fd_sc_hd__a221o_2_2 (a221o)
assign n174 = ((n451_reg | n517) & (n516)); // Xsky130_fd_sc_hd__o21a_2_21 (o21a)
assign n519 = ((n11_reg | n292) & (n518)); // Xsky130_fd_sc_hd__o21a_2_10 (o21a)
assign n289 = (n271_reg & n520); // Xsky130_fd_sc_hd__and2_2_11 (and2)
assign n290 = (n521_reg & ~(n91_reg)); // Xsky130_fd_sc_hd__and2b_2_23 (and2b)
assign n325 = (n73_reg & ~(n8_reg)); // Xsky130_fd_sc_hd__and2b_2_12 (and2b)
assign n229 = ((n223 & n74) | (n53) | (n78)); // Xsky130_fd_sc_hd__a211o_2_1 (a211o)
always @(posedge clk) begin
    n73_reg <= n431;
end

assign n523 = ~((n522) | (n154 & n7)); // Xsky130_fd_sc_hd__a21oi_2_15 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n142_reg <= 1'b0;
    else
        n142_reg <= n524;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n309_reg <= 1'b0;
    else
        n309_reg <= n525;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n526_reg <= 1'b0;
    else
        n526_reg <= n527;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n521_reg <= 1'b0;
    else
        n521_reg <= n528;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n530_reg <= 1'b0;
    else
        n530_reg <= n531;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n63_reg <= 1'b0;
    else
        n63_reg <= n247;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n532_reg <= 1'b0;
    else
        n532_reg <= n533;
end

assign n422 = ~(n417_reg); // Xsky130_fd_sc_hd__inv_2_16 (inv)
assign n15 = ~(n350 & n13); // Xsky130_fd_sc_hd__nand2_2_6 (nand2)
assign n534 = (n313 | n532_reg | n535 | n536); // Xsky130_fd_sc_hd__or4_2_8 (or4)
assign n537 = (~(n23_reg) & n199 & n538 & n231_reg); // Xsky130_fd_sc_hd__and4b_2_3 (and4b)
assign n539 = ~(n48 | n47 | n45); // Xsky130_fd_sc_hd__nor3_2_3 (nor3)
assign n280 = ~(n540_reg); // Xsky130_fd_sc_hd__inv_2_1 (inv)
assign n39 = (n204_reg ^ n299_reg); // Xsky130_fd_sc_hd__xor2_2_19 (xor2)
assign n541 = n237; // Xsky130_fd_sc_hd__clkbuf_4_8 (clkbuf)
assign n542 = (n68_reg | n8_reg | ~(n73_reg)); // Xsky130_fd_sc_hd__or3b_2_0 (or3b)
assign n543 = (n108_reg ^ n136_reg); // Xsky130_fd_sc_hd__xor2_2_0 (xor2)
assign n545 = (n544 & n546 & n547); // Xsky130_fd_sc_hd__and3_2_2 (and3)
assign n332 = ~(n6_reg & ~(n8_reg)); // Xsky130_fd_sc_hd__nand2b_2_9 (nand2b)
assign n513 = ((n548 & n37) | (n21 & n267_reg) | (n514)); // Xsky130_fd_sc_hd__a221o_2_3 (a221o)
assign n414 = ((n413_reg | n549) & (n534)); // Xsky130_fd_sc_hd__o21a_2_22 (o21a)
assign n552 = ((n550_reg | n141) & (n551)); // Xsky130_fd_sc_hd__o21a_2_11 (o21a)
assign n291 = (n453_reg & n499); // Xsky130_fd_sc_hd__and2_2_12 (and2)
assign n154 = (n68_reg & ~(n73_reg)); // Xsky130_fd_sc_hd__and2b_2_13 (and2b)
assign n288 = (n345_reg & ~(n134_reg)); // Xsky130_fd_sc_hd__and2b_2_24 (and2b)
assign n372 = ((n553 & n51) | (n245) | (n74)); // Xsky130_fd_sc_hd__a211o_2_2 (a211o)
always @(posedge clk) begin
    n68_reg <= n507;
end

assign n105 = ~((n554) | (n555 & n391)); // Xsky130_fd_sc_hd__a21oi_2_16 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n140_reg <= 1'b0;
    else
        n140_reg <= n444;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n261_reg <= 1'b0;
    else
        n261_reg <= n260;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n231_reg <= 1'b0;
    else
        n231_reg <= n556;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n447_reg <= 1'b0;
    else
        n447_reg <= n557;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n480_reg <= 1'b0;
    else
        n480_reg <= n558;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n459_reg <= 1'b0;
    else
        n459_reg <= n559;
end

assign n561 = ~((~(n560)) & (n332 | n464)); // Xsky130_fd_sc_hd__o21bai_2_0 (o21bai)
assign n520 = ~(n415_reg); // Xsky130_fd_sc_hd__inv_2_17 (inv)
assign n562 = ~(n563 & n458); // Xsky130_fd_sc_hd__nand2_2_7 (nand2)
assign n564 = (n282 | n271_reg | n520 | n565); // Xsky130_fd_sc_hd__or4_2_9 (or4)
assign n311 = ~(n566_reg); // Xsky130_fd_sc_hd__inv_2_2 (inv)
assign n296 = ~((n21 & n63_reg & n66_reg & n65_reg) | (n62_reg)); // Xsky130_fd_sc_hd__a41oi_2_0 (a41oi)
assign n567 = n340; // Xsky130_fd_sc_hd__clkbuf_4_9 (clkbuf)
assign n569 = (n63_reg ^ n181); // Xsky130_fd_sc_hd__xor2_2_1 (xor2)
assign n571 = (n570 & n78 & n572); // Xsky130_fd_sc_hd__and3_2_3 (and3)
assign n574 = ((n514 & n203_reg) | (n21 & n204_reg) | (n575)); // Xsky130_fd_sc_hd__a221o_2_4 (a221o)
assign n239 = ((n345_reg | n576) & (n133)); // Xsky130_fd_sc_hd__o21a_2_23 (o21a)
assign n411 = ((n577 | n551) & (n32)); // Xsky130_fd_sc_hd__o21a_2_12 (o21a)
assign n257 = (n532_reg & n535); // Xsky130_fd_sc_hd__and2_2_13 (and2)
assign n578 = (n68_reg & ~(n73_reg)); // Xsky130_fd_sc_hd__and2b_2_14 (and2b)
assign n256 = (n451_reg & ~(n173_reg)); // Xsky130_fd_sc_hd__and2b_2_25 (and2b)
assign n579 = ((n8_reg & n68_reg) | (n69) | (n580)); // Xsky130_fd_sc_hd__a211o_2_3 (a211o)
always @(posedge clk) begin
    n8_reg <= n581;
end

assign n582 = ~((n6_reg) | (n325 & n68_reg)); // Xsky130_fd_sc_hd__a21oi_2_17 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n136_reg <= 1'b0;
    else
        n136_reg <= n370;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n203_reg <= 1'b0;
    else
        n203_reg <= n574;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n550_reg <= 1'b0;
    else
        n550_reg <= n552;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n487_reg <= 1'b0;
    else
        n487_reg <= n583;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n347_reg <= 1'b0;
    else
        n347_reg <= n584;
end

assign n499 = ~(n302_reg); // Xsky130_fd_sc_hd__inv_2_18 (inv)
assign n585 = ~(n65_reg & n543); // Xsky130_fd_sc_hd__nand2_2_8 (nand2)
assign n354 = ~(n586_reg); // Xsky130_fd_sc_hd__inv_2_3 (inv)
assign n522 = (n8_reg ? n6_reg : n73_reg); // Xsky130_fd_sc_hd__mux2_1_20 (mux2)
assign n17 = (n56 ^ n587); // Xsky130_fd_sc_hd__xor2_2_2 (xor2)
assign n588 = (n252 & n253 & n251); // Xsky130_fd_sc_hd__and3_2_4 (and3)
assign n589 = ((n41_reg & n514) | (n21 & n101_reg) | (n590)); // Xsky130_fd_sc_hd__a221o_2_5 (a221o)
assign n384 = ((n490_reg | n592) & (n591)); // Xsky130_fd_sc_hd__o21a_2_24 (o21a)
assign n593 = ((n495 | n264) & (n323)); // Xsky130_fd_sc_hd__o21a_2_13 (o21a)
assign n165 = (n459_reg & n277); // Xsky130_fd_sc_hd__and2_2_14 (and2)
assign n56 = ((n594 & n350) | (n543 & n569 & n65_reg)); // Xsky130_fd_sc_hd__a32o_2_0 (a32o)
assign n258 = (n386_reg & ~(n493_reg)); // Xsky130_fd_sc_hd__and2b_2_26 (and2b)
assign n426 = (n71 & ~(n595)); // Xsky130_fd_sc_hd__and2b_2_15 (and2b)
assign n596 = ((n28 & n73_reg) | (n597) | (n424)); // Xsky130_fd_sc_hd__a211o_2_4 (a211o)
assign n31 = ~((n47) | (n48 & n45)); // Xsky130_fd_sc_hd__a21oi_2_18 (a21oi)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n108_reg <= 1'b0;
    else
        n108_reg <= n111;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n101_reg <= 1'b0;
    else
        n101_reg <= n598;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n599_reg <= 1'b0;
    else
        n599_reg <= n600;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n601_reg <= 1'b0;
    else
        n601_reg <= n602;
end

assign n535 = ~(n413_reg); // Xsky130_fd_sc_hd__inv_2_19 (inv)
assign n553 = ~(n350 & n603); // Xsky130_fd_sc_hd__nand2_2_9 (nand2)
assign n160 = (n13 | n308 | n498); // Xsky130_fd_sc_hd__or3_2_0 (or3)
assign n510 = ~(n603); // Xsky130_fd_sc_hd__inv_2_4 (inv)
assign n450 = (n21 ? n212_reg : n449_reg); // Xsky130_fd_sc_hd__mux2_1_10 (mux2)
assign n16 = (n350 ^ n594); // Xsky130_fd_sc_hd__xor2_2_3 (xor2)
assign n604 = (n484 & n486 & n446); // Xsky130_fd_sc_hd__and3_2_5 (and3)
assign n301 = ((n526_reg | n97) & (n605)); // Xsky130_fd_sc_hd__o21a_2_25 (o21a)
assign n575 = ((n314 | n360) & (n606)); // Xsky130_fd_sc_hd__o21a_2_14 (o21a)
assign n608 = (n607 & n191); // Xsky130_fd_sc_hd__and2_2_15 (and2)
assign n488 = ((n128 & n407) | (n420 & n408 & n74)); // Xsky130_fd_sc_hd__a32o_2_1 (a32o)
assign n168 = (n526_reg & ~(n99_reg)); // Xsky130_fd_sc_hd__and2b_2_27 (and2b)
assign n610 = (n201 & ~(n21)); // Xsky130_fd_sc_hd__and2b_2_16 (and2b)
assign n606 = ~((n122) | (n360 & n314)); // Xsky130_fd_sc_hd__a21oi_2_19 (a21oi)
assign n611 = ((n497 & n52) | (n51 & n503)); // Xsky130_fd_sc_hd__a22o_2_0 (a22o)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n612_reg <= 1'b0;
    else
        n612_reg <= n613;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n114_reg <= 1'b0;
    else
        n114_reg <= n614;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n615_reg <= 1'b0;
    else
        n615_reg <= n616;
end

assign n321 = (n74 | n618 | n619); // Xsky130_fd_sc_hd__or3_2_1 (or3)
assign n367 = ~(n115); // Xsky130_fd_sc_hd__inv_2_5 (inv)
assign n602 = (n21 ? n480_reg : n601_reg); // Xsky130_fd_sc_hd__mux2_1_11 (mux2)
assign n435 = (n113_reg ^ n337); // Xsky130_fd_sc_hd__xor2_2_4 (xor2)
assign n538 = (n84 & n129 & n604); // Xsky130_fd_sc_hd__and3_2_6 (and3)
assign n620 = ((n73_reg | n437) & (n436)); // Xsky130_fd_sc_hd__o21a_2_15 (o21a)
assign n276 = ((n275_reg | n621) & (n460)); // Xsky130_fd_sc_hd__o21a_2_26 (o21a)
assign n201 = (n23_reg & n24); // Xsky130_fd_sc_hd__and2_2_16 (and2)
assign n524 = ((n142_reg & n305) | (n21 & n92 & I)); // Xsky130_fd_sc_hd__a32o_2_2 (a32o)
assign n255 = (n490_reg & ~(n383_reg)); // Xsky130_fd_sc_hd__and2b_2_28 (and2b)
assign n580 = (n73_reg & ~(n68_reg)); // Xsky130_fd_sc_hd__and2b_2_17 (and2b)
assign n555 = ~(n73_reg & n6_reg); // Xsky130_fd_sc_hd__nand2_2_30 (nand2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n113_reg <= 1'b0;
    else
        n113_reg <= n375;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n176_reg <= 1'b0;
    else
        n176_reg <= n410;
end

assign n600 = ((n150 & n599_reg) | (n622 & n405)); // Xsky130_fd_sc_hd__a22o_2_1 (a22o)
assign n623 = n175; // Xsky130_fd_sc_hd__clkbuf_4_10 (clkbuf)
assign n243 = (n13 | n498 | n79); // Xsky130_fd_sc_hd__or3_2_2 (or3)
assign n607 = ~(n612_reg); // Xsky130_fd_sc_hd__inv_2_6 (inv)
assign n558 = (n21 ? n449_reg : n480_reg); // Xsky130_fd_sc_hd__mux2_1_12 (mux2)
assign n570 = ((n511) | (n52) | (n350 & n74 & n351)); // Xsky130_fd_sc_hd__a311o_2_0 (a311o)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n41_reg <= 1'b1;
    else
        n41_reg <= n589;
end

assign n226 = (n363 ^ n624); // Xsky130_fd_sc_hd__xor2_2_5 (xor2)
assign n110 = (n21 & n58 & n369); // Xsky130_fd_sc_hd__and3_2_7 (and3)
assign n492 = ((n487_reg | n625) & (n18)); // Xsky130_fd_sc_hd__o21a_2_16 (o21a)
assign n344 = ((n206_reg | n25) & (n626)); // Xsky130_fd_sc_hd__o21a_2_27 (o21a)
assign n238 = ((n627 & n116_reg) | (n608 & n537 & n393)); // Xsky130_fd_sc_hd__a32o_2_3 (a32o)
assign n44 = clk; // Xsky130_fd_sc_hd__clkbuf_16_0 (clkbuf)
assign n167 = (n206_reg & ~(n27_reg)); // Xsky130_fd_sc_hd__and2b_2_29 (and2b)
assign n467 = (n548 & ~(n430)); // Xsky130_fd_sc_hd__and2b_2_18 (and2b)
assign n475 = ~(n8_reg & n6_reg); // Xsky130_fd_sc_hd__nand2_2_20 (nand2)
assign n185 = ~(n628 & n629); // Xsky130_fd_sc_hd__nand2_2_31 (nand2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n222_reg <= 1'b0;
    else
        n222_reg <= n248;
end

assign n481 = ((n394 & n342_reg) | (n601_reg & n502)); // Xsky130_fd_sc_hd__a22o_2_2 (a22o)
assign n630 = n208; // Xsky130_fd_sc_hd__clkbuf_4_11 (clkbuf)
assign n22 = ((n631 | n632 | n634) & (n633)); // Xsky130_fd_sc_hd__o31a_2_10 (o31a)
assign n635 = (n13 | n17 | n503); // Xsky130_fd_sc_hd__or3_2_3 (or3)
assign n150 = ~(n21); // Xsky130_fd_sc_hd__inv_2_7 (inv)
assign n343 = (n21 ? I : n342_reg); // Xsky130_fd_sc_hd__mux2_1_13 (mux2)
assign n636 = ((n329) | (n159) | (n331 & n332 & n328)); // Xsky130_fd_sc_hd__a311o_2_1 (a311o)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n38_reg <= 1'b1;
    else
        n38_reg <= n121;
end

assign n637 = ((n186 | n330 | n463) & (n636)); // Xsky130_fd_sc_hd__o31a_2_0 (o31a)
assign n189 = (n362 ^ n124); // Xsky130_fd_sc_hd__xor2_2_6 (xor2)
assign n34 = (n140_reg & n142_reg & n550_reg); // Xsky130_fd_sc_hd__and3_2_8 (and3)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n638_reg <= 1'b0;
    else
        n638_reg <= n639;
end

assign n494 = ((n386_reg | n642) & (n641)); // Xsky130_fd_sc_hd__o21a_2_28 (o21a)
assign n418 = ((n417_reg | n643) & (n421)); // Xsky130_fd_sc_hd__o21a_2_17 (o21a)
assign n209 = ((n627 & success_reg) | (n608 & n537 & n348)); // Xsky130_fd_sc_hd__a32o_2_4 (a32o)
assign n644 = (n157 & ~(n7)); // Xsky130_fd_sc_hd__and2b_2_19 (and2b)
assign n645 = ((n40 & n29) | (n646 & n106)); // Xsky130_fd_sc_hd__a22o_2_20 (a22o)
assign n647 = ~(n74 & n14); // Xsky130_fd_sc_hd__nand2_2_10 (nand2)
assign n546 = ~(n108_reg & n114_reg); // Xsky130_fd_sc_hd__nand2_2_21 (nand2)
assign n391 = ~(n8_reg & n580); // Xsky130_fd_sc_hd__nand2_2_32 (nand2)
assign n629 = ((n554 & n70) | (n542 & n170)); // Xsky130_fd_sc_hd__a22o_2_3 (a22o)
assign n648 = n385; // Xsky130_fd_sc_hd__clkbuf_4_12 (clkbuf)
assign n219 = (n74 | n52 | n163); // Xsky130_fd_sc_hd__or3_2_4 (or3)
assign n151 = ~(n176_reg); // Xsky130_fd_sc_hd__inv_2_8 (inv)
assign n341 = (n21 ? n379_reg : n211_reg); // Xsky130_fd_sc_hd__mux2_1_14 (mux2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n169_reg <= 1'b1;
    else
        n169_reg <= n649;
end

assign n284 = ((n8_reg | n554 | n580) & (n555)); // Xsky130_fd_sc_hd__o31a_2_1 (o31a)
assign n337 = (n108_reg ^ n114_reg); // Xsky130_fd_sc_hd__xor2_2_7 (xor2)
assign n36 = (I & n218_reg & n21); // Xsky130_fd_sc_hd__and3_2_9 (and3)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n540_reg <= 1'b0;
    else
        n540_reg <= n651;
end

assign n416 = ((n415_reg | n652) & (n564)); // Xsky130_fd_sc_hd__o21a_2_29 (o21a)
assign n455 = ((n447_reg | n654) & (n653)); // Xsky130_fd_sc_hd__o21a_2_18 (o21a)
assign n245 = ((n13 | n503) & (n17)); // Xsky130_fd_sc_hd__o21a_2_0 (o21a)
assign n656 = ((n655 & n46) | (n523 & n539)); // Xsky130_fd_sc_hd__a22o_2_21 (a22o)
assign n657 = ((n104 & n29) | (n561 & n106)); // Xsky130_fd_sc_hd__a22o_2_10 (a22o)
assign n420 = ~(n51 & n497); // Xsky130_fd_sc_hd__nand2_2_11 (nand2)
assign n565 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_33 (nand2)
assign n544 = ~(n113_reg & n337); // Xsky130_fd_sc_hd__nand2_2_22 (nand2)
assign n658 = ((n21 & n169_reg) | (n101_reg & n514)); // Xsky130_fd_sc_hd__a22o_2_4 (a22o)
assign n259 = ~(n21 & I & n2 & n638_reg); // Xsky130_fd_sc_hd__nand4_2_0 (nand4)
assign n659 = n210; // Xsky130_fd_sc_hd__clkbuf_4_13 (clkbuf)
assign n251 = (n661 | n316 | n545); // Xsky130_fd_sc_hd__or3_2_5 (or3)
assign n622 = ~(n58); // Xsky130_fd_sc_hd__inv_2_9 (inv)
assign n560 = (n662 & ~(n464) & n329); // Xsky130_fd_sc_hd__and3b_2_0 (and3b)
assign n594 = ~(n458 | n563); // Xsky130_fd_sc_hd__nor2_2_0 (nor2)
assign n380 = (n21 ? n530_reg : n379_reg); // Xsky130_fd_sc_hd__mux2_1_15 (mux2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n267_reg <= 1'b1;
    else
        n267_reg <= n468;
end

assign n655 = ((n264 | n578 | n663) & (n323)); // Xsky130_fd_sc_hd__o31a_2_2 (o31a)
assign n590 = ~(n122 | n146); // Xsky130_fd_sc_hd__nor2_2_40 (nor2)
assign n74 = (n54 ^ n664); // Xsky130_fd_sc_hd__xor2_2_8 (xor2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n278_reg <= 1'b0;
    else
        n278_reg <= n665;
end

assign n236 = ((n521_reg | n666) & (n90)); // Xsky130_fd_sc_hd__o21a_2_19 (o21a)
assign n77 = ((n17 | n667) & (n408)); // Xsky130_fd_sc_hd__o21a_2_1 (o21a)
assign n350 = ~(n585 ^ n569); // Xsky130_fd_sc_hd__xnor2_2_0 (xnor2)
assign n668 = ((n232 & n29) | (n637 & n106)); // Xsky130_fd_sc_hd__a22o_2_11 (a22o)
assign n145 = ((n68_reg & n669) | (n8_reg & n628)); // Xsky130_fd_sc_hd__a22o_2_22 (a22o)
assign n335 = ~(n74 & n670); // Xsky130_fd_sc_hd__nand2_2_12 (nand2)
assign n109 = ~(n58 & n21); // Xsky130_fd_sc_hd__nand2_2_23 (nand2)
assign n423 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_34 (nand2)
assign n671 = ((n21 & n203_reg) | (n514 & n169_reg)); // Xsky130_fd_sc_hd__a22o_2_5 (a22o)
assign n292 = ~(n21 & I & n672 & n12_reg); // Xsky130_fd_sc_hd__nand4_2_1 (nand4)
assign n673 = n43; // Xsky130_fd_sc_hd__clkbuf_4_14 (clkbuf)
assign n445 = ((n140_reg) | (n142_reg & n36)); // Xsky130_fd_sc_hd__a21o_2_10 (a21o)
assign n674 = (n434 | n424 | n597); // Xsky130_fd_sc_hd__or3_2_6 (or3)
assign n675 = (n8_reg & ~(n6_reg) & n73_reg); // Xsky130_fd_sc_hd__and3b_2_1 (and3b)
assign n498 = ~(n351 | n409); // Xsky130_fd_sc_hd__nor2_2_1 (nor2)
assign n531 = (n21 ? n241_reg : n530_reg); // Xsky130_fd_sc_hd__mux2_1_16 (mux2)
assign n207 = ~(n25 & ~(n206_reg)); // Xsky130_fd_sc_hd__nand2b_2_20 (nand2b)
assign n164 = ((n631 | n676 | n645) & (n677)); // Xsky130_fd_sc_hd__o31a_2_3 (o31a)
assign n652 = ~(n565 | n282); // Xsky130_fd_sc_hd__nor2_2_41 (nor2)
assign n489 = ~(n377 | n36); // Xsky130_fd_sc_hd__nor2_2_30 (nor2)
assign n614 = (n114_reg ^ n115); // Xsky130_fd_sc_hd__xor2_2_9 (xor2)
assign n161 = (n307 & n351); // Xsky130_fd_sc_hd__and2_2_0 (and2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n352_reg <= 1'b0;
    else
        n352_reg <= n678;
end

assign n679 = ((n17 | n603) & (n223)); // Xsky130_fd_sc_hd__o21a_2_2 (o21a)
assign n563 = ~(n65_reg ^ n543); // Xsky130_fd_sc_hd__xnor2_2_1 (xnor2)
assign n681 = ((n680 & n46) | (n438 & n539)); // Xsky130_fd_sc_hd__a22o_2_12 (a22o)
assign n461 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_35 (nand2)
assign n551 = ~(n36 & n34); // Xsky130_fd_sc_hd__nand2_2_24 (nand2)
assign n355 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_13 (nand2)
assign n597 = ~(~(n6_reg) | n8_reg | n68_reg | n73_reg); // Xsky130_fd_sc_hd__nor4b_2_0 (nor4b)
assign n676 = ((n682 & n46) | (n683 & n539)); // Xsky130_fd_sc_hd__a22o_2_6 (a22o)
assign n319 = ~(n21 & I & n684 & n82_reg); // Xsky130_fd_sc_hd__nand4_2_2 (nand4)
assign n649 = ((n671) | (n610 & n268)); // Xsky130_fd_sc_hd__a21o_2_11 (a21o)
assign n193 = (n441 | n322 | n221); // Xsky130_fd_sc_hd__or3_2_7 (or3)
assign n685 = (n154 & ~(n6_reg) & n8_reg); // Xsky130_fd_sc_hd__and3b_2_2 (and3b)
assign n79 = ~(n603 | n308); // Xsky130_fd_sc_hd__nor2_2_2 (nor2)
assign n412 = (n21 ? n615_reg : n240_reg); // Xsky130_fd_sc_hd__mux2_1_17 (mux2)
assign n387 = ~(n642 & ~(n386_reg)); // Xsky130_fd_sc_hd__nand2b_2_21 (nand2b)
assign n662 = ~(n8_reg & ~(n68_reg)); // Xsky130_fd_sc_hd__nand2b_2_10 (nand2b)
assign n406 = ((n631 | n686 | n688) & (n687)); // Xsky130_fd_sc_hd__o31a_2_4 (o31a)
assign n194 = ~(n137 | n689); // Xsky130_fd_sc_hd__nor2_2_20 (nor2)
assign n456 = ~(n690 | n58); // Xsky130_fd_sc_hd__nor2_2_31 (nor2)
assign n643 = ~(n423 | n246); // Xsky130_fd_sc_hd__nor2_2_42 (nor2)
assign n691 = (n66_reg & n108_reg); // Xsky130_fd_sc_hd__and2_2_1 (and2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n404_reg <= 1'b0;
    else
        n404_reg <= n403;
end

assign n692 = ((n13 | n420) & (n326)); // Xsky130_fd_sc_hd__o21a_2_3 (o21a)
assign n308 = ~(n350 ^ n594); // Xsky130_fd_sc_hd__xnor2_2_2 (xnor2)
assign n632 = ((n693 & n46) | (n155 & n539)); // Xsky130_fd_sc_hd__a22o_2_13 (a22o)
assign n500 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_36 (nand2)
assign n117 = ~(~(n192) | n35_reg | n142_reg | n140_reg); // Xsky130_fd_sc_hd__nor4b_2_1 (nor4b)
assign n281 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_14 (nand2)
assign n178 = ~(n599_reg & I); // Xsky130_fd_sc_hd__nand2_2_25 (nand2)
assign n686 = ((n582 & n46) | (n620 & n539)); // Xsky130_fd_sc_hd__a22o_2_7 (a22o)
assign n402 = ~(n21 & I & n695 & n696_reg); // Xsky130_fd_sc_hd__nand4_2_3 (nand4)
assign n465 = ((n514) | (n21 & n299_reg)); // Xsky130_fd_sc_hd__a21o_2_12 (a21o)
assign n505 = (n218_reg | n550_reg | n217_reg); // Xsky130_fd_sc_hd__or3_2_8 (or3)
assign n466 = (n146 & ~(n21) & n430); // Xsky130_fd_sc_hd__and3b_2_3 (and3b)
assign n357 = ~(n127 | n17); // Xsky130_fd_sc_hd__nor2_2_3 (nor2)
assign n382 = (n21 ? n342_reg : n381_reg); // Xsky130_fd_sc_hd__mux2_1_18 (mux2)
assign n122 = ~(n201 & ~(n21)); // Xsky130_fd_sc_hd__nand2b_2_22 (nand2b)
assign n628 = ~(n68_reg & ~(n73_reg)); // Xsky130_fd_sc_hd__nand2b_2_11 (nand2b)
assign n96 = ((n631 | n681 | n697) & (n30)); // Xsky130_fd_sc_hd__o31a_2_5 (o31a)
assign n698 = 1'b1; // Xsky130_fd_sc_hd__conb_1_0 (conb)
assign n646 = 1'b0; // Xsky130_fd_sc_hd__conb_1_0 (conb)
assign n127 = ~(n498 | n308); // Xsky130_fd_sc_hd__nor2_2_10 (nor2)
assign n664 = ~(n588 | n254); // Xsky130_fd_sc_hd__nor2_2_21 (nor2)
assign n156 = ~(n154 | n6_reg); // Xsky130_fd_sc_hd__nor2_2_32 (nor2)
assign n483 = ~(n500 | n359); // Xsky130_fd_sc_hd__nor2_2_43 (nor2)
assign n667 = (n349 & n306); // Xsky130_fd_sc_hd__and2_2_2 (and2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n82_reg <= 1'b0;
    else
        n82_reg <= n699;
end

assign n639 = ((n261_reg | n259) & (n700)); // Xsky130_fd_sc_hd__o21a_2_4 (o21a)
assign n547 = ~(n136_reg ^ n113_reg); // Xsky130_fd_sc_hd__xnor2_2_3 (xnor2)
assign n701 = ((n324 & n46) | (n685 & n539)); // Xsky130_fd_sc_hd__a22o_2_14 (a22o)
assign n577 = ~(n35_reg & n33_reg); // Xsky130_fd_sc_hd__nand2_2_26 (nand2)
assign n312 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_15 (nand2)
assign n536 = ~(I & n21); // Xsky130_fd_sc_hd__nand2_2_37 (nand2)
assign n697 = ((n283 & n29) | (n702 & n106)); // Xsky130_fd_sc_hd__a22o_2_8 (a22o)
assign n625 = ~(n21 & I & n20 & n19_reg); // Xsky130_fd_sc_hd__nand4_2_4 (nand4)
assign n339 = ((n338_reg) | (n417_reg & n643)); // Xsky130_fd_sc_hd__a21o_2_13 (a21o)
assign n233 = (n554 | n595 | n669); // Xsky130_fd_sc_hd__or3_2_9 (or3)
assign n409 = ~(n703 | n691); // Xsky130_fd_sc_hd__nor2_2_4 (nor2)
assign n616 = (n21 ? n381_reg : n615_reg); // Xsky130_fd_sc_hd__mux2_1_19 (mux2)
assign n627 = ~(n231_reg & ~(n23_reg)); // Xsky130_fd_sc_hd__nand2b_2_23 (nand2b)
assign n157 = ~(n73_reg & ~(n68_reg)); // Xsky130_fd_sc_hd__nand2b_2_12 (nand2b)
assign n371 = ((n631 | n704 | n668) & (n705)); // Xsky130_fd_sc_hd__o31a_2_6 (o31a)
assign n707 = 1'b1; // Xsky130_fd_sc_hd__conb_1_1 (conb)
assign n706 = 1'b0; // Xsky130_fd_sc_hd__conb_1_1 (conb)
assign n619 = ~(n223 | n17); // Xsky130_fd_sc_hd__nor2_2_11 (nor2)
assign n464 = ~(n73_reg | n68_reg); // Xsky130_fd_sc_hd__nor2_2_22 (nor2)
assign n549 = ~(n536 | n313); // Xsky130_fd_sc_hd__nor2_2_44 (nor2)
assign n709 = ~(n73_reg | n68_reg); // Xsky130_fd_sc_hd__nor2_2_33 (nor2)
assign n710 = ((n73_reg) & (n323) & (n8_reg | n495)); // Xsky130_fd_sc_hd__o211a_2_10 (o211a)
assign n86 = (n278_reg & n280); // Xsky130_fd_sc_hd__and2_2_3 (and2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n12_reg <= 1'b0;
    else
        n12_reg <= n519;
end

assign n712 = ((n404_reg | n402) & (n711)); // Xsky130_fd_sc_hd__o21a_2_5 (o21a)
assign n713 = ~(n317 ^ n435); // Xsky130_fd_sc_hd__xnor2_2_4 (xnor2)
assign n704 = ((n593 & n46) | (n675 & n539)); // Xsky130_fd_sc_hd__a22o_2_15 (a22o)
assign n252 = ~(n62_reg & n713); // Xsky130_fd_sc_hd__nand2_2_16 (nand2)
assign n437 = ~(n68_reg & n7); // Xsky130_fd_sc_hd__nand2_2_27 (nand2)
assign n714 = ~(n267_reg & n265); // Xsky130_fd_sc_hd__nand2_2_38 (nand2)
assign n688 = ((n144 & n29) | (n474 & n106)); // Xsky130_fd_sc_hd__a22o_2_9 (a22o)
assign n364 = ~(n21 & I & n462 & n388_reg); // Xsky130_fd_sc_hd__nand4_2_5 (nand4)
assign n454 = ((n453_reg) | (n302_reg & n483)); // Xsky130_fd_sc_hd__a21o_2_14 (a21o)
assign n373 = ~(n17 | n15); // Xsky130_fd_sc_hd__nor2_2_5 (nor2)
assign n557 = ~(n654 & ~(n447_reg)); // Xsky130_fd_sc_hd__nand2b_2_13 (nand2b)
assign n197 = ((n631 | n715 | n717) & (n716)); // Xsky130_fd_sc_hd__o31a_2_7 (o31a)
assign n478 = 1'b1; // Xsky130_fd_sc_hd__conb_1_2 (conb)
assign n718 = 1'b0; // Xsky130_fd_sc_hd__conb_1_2 (conb)
assign n52 = ~(n127 | n51); // Xsky130_fd_sc_hd__nor2_2_12 (nor2)
assign n719 = ~(n473 | n6_reg); // Xsky130_fd_sc_hd__nor2_2_23 (nor2)
assign n621 = ~(n461 | n398); // Xsky130_fd_sc_hd__nor2_2_45 (nor2)
assign n548 = ~(n146 | n21); // Xsky130_fd_sc_hd__nor2_2_34 (nor2)
assign n581 = ((n23_reg) & (n720) & (n469 | n6_reg)); // Xsky130_fd_sc_hd__o211a_2_11 (o211a)
assign n131 = (n309_reg & n311); // Xsky130_fd_sc_hd__and2_2_4 (and2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n566_reg <= 1'b0;
    else
        n566_reg <= n721;
end

assign n723 = ((n586_reg | n722) & (n353)); // Xsky130_fd_sc_hd__o21a_2_6 (o21a)
assign n724 = ~(n62_reg ^ n713); // Xsky130_fd_sc_hd__xnor2_2_5 (xnor2)
assign n125 = ~((n725 | n287) & (n136_reg | n544)); // Xsky130_fd_sc_hd__o22ai_2_0 (o22ai)
assign n715 = ((n710 & n46) | (n644 & n539)); // Xsky130_fd_sc_hd__a22o_2_16 (a22o)
assign n726 = ((n161) | (n306 & n17 & n349)); // Xsky130_fd_sc_hd__a31o_2_0 (a31o)
assign n317 = ~(n136_reg & n114_reg); // Xsky130_fd_sc_hd__nand2_2_17 (nand2)
assign n427 = ~(n70 & n170); // Xsky130_fd_sc_hd__nand2_2_28 (nand2)
assign n654 = ~(n21 & I & n103 & n448_reg); // Xsky130_fd_sc_hd__nand4_2_6 (nand4)
assign n533 = ((n532_reg) | (n413_reg & n549)); // Xsky130_fd_sc_hd__a21o_2_15 (a21o)
assign n223 = (n351 | n16); // Xsky130_fd_sc_hd__or2_2_0 (or2)
assign n336 = ~(n114_reg | n136_reg); // Xsky130_fd_sc_hd__nor2_2_6 (nor2)
assign n528 = ~(n666 & ~(n521_reg)); // Xsky130_fd_sc_hd__nand2b_2_14 (nand2b)
assign n138 = ((n631 | n701 | n728) & (n727)); // Xsky130_fd_sc_hd__o31a_2_8 (o31a)
assign n729 = 1'b1; // Xsky130_fd_sc_hd__conb_1_3 (conb)
assign n683 = 1'b0; // Xsky130_fd_sc_hd__conb_1_3 (conb)
assign n396 = ~(n160 | n51); // Xsky130_fd_sc_hd__nor2_2_13 (nor2)
assign n515 = ~(n100 | n122); // Xsky130_fd_sc_hd__nor2_2_46 (nor2)
assign n730 = ~(n6_reg | n73_reg); // Xsky130_fd_sc_hd__nor2_2_24 (nor2)
assign n428 = ~(n426 | n8_reg); // Xsky130_fd_sc_hd__nor2_2_35 (nor2)
assign n591 = ((n383_reg) | (n501 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_20 (a31o)
assign n88 = (n352_reg & n354); // Xsky130_fd_sc_hd__and2_2_5 (and2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n696_reg <= 1'b0;
    else
        n696_reg <= n712;
end

assign n651 = ((n540_reg | n733) & (n279)); // Xsky130_fd_sc_hd__o21a_2_7 (o21a)
assign n734 = ~(n560 ^ n735); // Xsky130_fd_sc_hd__xnor2_2_6 (xnor2)
assign n440 = ~((n189 | n635) & (n51 | n497)); // Xsky130_fd_sc_hd__o22ai_2_1 (o22ai)
assign n634 = ((n506 & n29) | (n734 & n106)); // Xsky130_fd_sc_hd__a22o_2_17 (a22o)
assign n700 = ((n638_reg) | (n2 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_1 (a31o)
assign n57 = ~(n724 & n180); // Xsky130_fd_sc_hd__nand2_2_18 (nand2)
assign n71 = ~(n68_reg & n73_reg); // Xsky130_fd_sc_hd__nand2_2_29 (nand2)
assign n572 = ~((n74) & (n511 | n52)); // Xsky130_fd_sc_hd__o21ai_2_0 (o21ai)
assign n666 = ~(n21 & I & n64 & n91_reg); // Xsky130_fd_sc_hd__nand4_2_7 (nand4)
assign n559 = ((n459_reg) | (n275_reg & n621)); // Xsky130_fd_sc_hd__a21o_2_16 (a21o)
assign n665 = ((n278_reg) | (n540_reg & n733)); // Xsky130_fd_sc_hd__a21o_2_0 (a21o)
assign n307 = (n703 | n691); // Xsky130_fd_sc_hd__or2_2_1 (or2)
assign n703 = ~(n108_reg | n66_reg); // Xsky130_fd_sc_hd__nor2_2_7 (nor2)
assign n583 = ~(n625 & ~(n487_reg)); // Xsky130_fd_sc_hd__nand2b_2_15 (nand2b)
assign n227 = ((n631 | n656 | n657) & (n736)); // Xsky130_fd_sc_hd__o31a_2_9 (o31a)
assign n737 = 1'b1; // Xsky130_fd_sc_hd__conb_1_4 (conb)
assign n680 = 1'b0; // Xsky130_fd_sc_hd__conb_1_4 (conb)
assign n722 = ~(n355 | n183); // Xsky130_fd_sc_hd__nor2_2_14 (nor2)
assign n631 = ~(n31 | n29); // Xsky130_fd_sc_hd__nor2_2_47 (nor2)
assign n661 = ~(n544 | n136_reg); // Xsky130_fd_sc_hd__nor2_2_25 (nor2)
assign n554 = ~(n69 | n68_reg); // Xsky130_fd_sc_hd__nor2_2_36 (nor2)
assign n605 = ((n99_reg) | (n98 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_21 (a31o)
assign n249 = ((n222_reg) | (n34 & n95 & n36)); // Xsky130_fd_sc_hd__a31o_2_10 (a31o)
assign n331 = (n68_reg & n73_reg); // Xsky130_fd_sc_hd__and2_2_6 (and2)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        n586_reg <= 1'b0;
    else
        n586_reg <= n723;
end

assign n699 = ((n81_reg | n319) & (n738)); // Xsky130_fd_sc_hd__o21a_2_8 (o21a)
assign n441 = ~(n363 ^ n624); // Xsky130_fd_sc_hd__xnor2_2_7 (xnor2)
assign n705 = (n739 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_10 (or3)
assign n717 = ((n740 & n29) | (n741 & n106)); // Xsky130_fd_sc_hd__a22o_2_18 (a22o)
assign n738 = ((n82_reg) | (n684 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_2 (a31o)
assign n473 = ~(n68_reg & n73_reg); // Xsky130_fd_sc_hd__nand2_2_19 (nand2)
assign n126 = (~(n108_reg) & n114_reg & ~(n136_reg) & n113_reg); // Xsky130_fd_sc_hd__and4bb_2_0 (and4bb)
assign n263 = ~((n244) & (n358 | n189)); // Xsky130_fd_sc_hd__o21ai_2_1 (o21ai)
assign n576 = ~(n21 & I & n135 & n134_reg); // Xsky130_fd_sc_hd__nand4_2_8 (nand4)
assign n720 = ((n8_reg) | (n73_reg & n68_reg)); // Xsky130_fd_sc_hd__a21o_2_17 (a21o)
assign n525 = ((n309_reg) | (n566_reg & n742)); // Xsky130_fd_sc_hd__a21o_2_1 (a21o)
assign n503 = (n498 | n16); // Xsky130_fd_sc_hd__or2_2_2 (or2)
assign n13 = ~(n307 | n563); // Xsky130_fd_sc_hd__nor2_2_8 (nor2)
assign n452 = ~(n517 & ~(n451_reg)); // Xsky130_fd_sc_hd__nand2b_2_16 (nand2b)
assign n743 = 1'b1; // Xsky130_fd_sc_hd__conb_1_5 (conb)
assign n682 = 1'b0; // Xsky130_fd_sc_hd__conb_1_5 (conb)
assign n669 = ~(n6_reg | n8_reg); // Xsky130_fd_sc_hd__nor2_2_37 (nor2)
assign n334 = ~(n51 | n15); // Xsky130_fd_sc_hd__nor2_2_26 (nor2)
assign n733 = ~(n281 | n158); // Xsky130_fd_sc_hd__nor2_2_15 (nor2)
assign n45 = ~(n744 | n117); // Xsky130_fd_sc_hd__nor2_2_48 (nor2)
assign n369 = ~(n136_reg & ~(n114_reg) & n113_reg); // Xsky130_fd_sc_hd__nand3b_2_0 (nand3b)
assign n626 = ((n27_reg) | (n26 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_22 (a31o)
assign n613 = ((n612_reg) | (n179 & n58 & n21)); // Xsky130_fd_sc_hd__a31o_2_11 (a31o)
assign n745 = (n73_reg & n662); // Xsky130_fd_sc_hd__and2_2_7 (and2)
assign n721 = ((n566_reg | n742) & (n310)); // Xsky130_fd_sc_hd__o21a_2_9 (o21a)
assign n587 = ~(n724 ^ n180); // Xsky130_fd_sc_hd__xnor2_2_8 (xnor2)
assign n716 = (n746 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_11 (or3)
assign n728 = ((n184 & n29) | (n719 & n106)); // Xsky130_fd_sc_hd__a22o_2_19 (a22o)
assign n693 = ~((n709) | (n325) | (n8_reg & n68_reg) | (n6_reg)); // Xsky130_fd_sc_hd__a2111oi_2_0 (a2111oi)
assign n518 = ((n12_reg) | (n672 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_3 (a31o)
assign n695 = (~(n0) & n4 & ~(n1) & n3); // Xsky130_fd_sc_hd__and4bb_2_1 (and4bb)
assign n75 = ~((n74) & (n504 | n17)); // Xsky130_fd_sc_hd__o21ai_2_2 (o21ai)
assign n517 = ~(n21 & I & n143 & n173_reg); // Xsky130_fd_sc_hd__nand4_2_9 (nand4)
assign n272 = ((n271_reg) | (n415_reg & n652)); // Xsky130_fd_sc_hd__a21o_2_18 (a21o)
assign n678 = ((n352_reg) | (n586_reg & n722)); // Xsky130_fd_sc_hd__a21o_2_2 (a21o)
assign n326 = (n498 | n51); // Xsky130_fd_sc_hd__or2_2_3 (or2)
assign n603 = ~(n562 | n703); // Xsky130_fd_sc_hd__nor2_2_9 (nor2)
assign n346 = ~(n576 & ~(n345_reg)); // Xsky130_fd_sc_hd__nand2b_2_17 (nand2b)
assign n595 = ~(n73_reg | n68_reg); // Xsky130_fd_sc_hd__nor2_2_38 (nor2)
assign n395 = ~(n420 | n127); // Xsky130_fd_sc_hd__nor2_2_27 (nor2)
assign n742 = ~(n312 | n214); // Xsky130_fd_sc_hd__nor2_2_16 (nor2)
assign n641 = ((n493_reg) | (n432 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_23 (a31o)
assign n584 = ((n347_reg) | (n477 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_12 (a31o)
assign n741 = (n473 & n475); // Xsky130_fd_sc_hd__and2_2_8 (and2)
assign n51 = ~(n56 ^ n587); // Xsky130_fd_sc_hd__xnor2_2_9 (xnor2)
assign n687 = (n674 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_12 (or3)
assign n711 = ((n696_reg) | (n695 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_4 (a31o)
assign n672 = (~(n3) & n1 & ~(n0) & n4); // Xsky130_fd_sc_hd__and4bb_2_2 (and4bb)
assign n385 = n44; // Xsky130_fd_sc_hd__clkbuf_8_10 (clkbuf)
assign n123 = ~((n399) & (n146 | I)); // Xsky130_fd_sc_hd__o21ai_2_3 (o21ai)
assign n225 = ((n571) | (n189 & n374)); // Xsky130_fd_sc_hd__a21o_2_3 (a21o)
assign n408 = (n223 | n51); // Xsky130_fd_sc_hd__or2_2_4 (or2)
assign n491 = ~(n592 & ~(n490_reg)); // Xsky130_fd_sc_hd__nand2b_2_18 (nand2b)
assign n316 = ~(n547 | n546); // Xsky130_fd_sc_hd__nor2_2_17 (nor2)
assign n618 = ~(n349 | n17); // Xsky130_fd_sc_hd__nor2_2_28 (nor2)
assign n514 = ~(n21 | n201); // Xsky130_fd_sc_hd__nor2_2_39 (nor2)
assign n556 = ((n231_reg) | (n21 & n58 & n747)); // Xsky130_fd_sc_hd__a31o_2_13 (a31o)
assign n516 = ((n173_reg) | (n143 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_24 (a31o)
assign n95 = (n35_reg & n33_reg); // Xsky130_fd_sc_hd__and2_2_9 (and2)
assign n677 = (n706 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_13 (or3)
assign n195 = ((n226) | (n647 & n189 & n327)); // Xsky130_fd_sc_hd__a31o_2_5 (a31o)
assign n269 = ~(n267_reg ^ n169_reg); // Xsky130_fd_sc_hd__xnor2_2_20 (xnor2)
assign n684 = (~(n4) & n1 & ~(n0) & n3); // Xsky130_fd_sc_hd__and4bb_2_3 (and4bb)
assign n208 = n44; // Xsky130_fd_sc_hd__clkbuf_8_11 (clkbuf)
assign n748 = ~((n579) & (n427 | n392)); // Xsky130_fd_sc_hd__o21ai_2_4 (o21ai)
assign n376 = ~(n114_reg & n113_reg & n115); // Xsky130_fd_sc_hd__nand3_2_0 (nand3)
assign n749 = (n74 ? n726 : n692); // Xsky130_fd_sc_hd__mux2_1_0 (mux2)
assign n624 = ((n318) | (n317 & n316)); // Xsky130_fd_sc_hd__a21o_2_4 (a21o)
assign n439 = (n618 | n189); // Xsky130_fd_sc_hd__or2_2_5 (or2)
assign n527 = ~(n97 & ~(n526_reg)); // Xsky130_fd_sc_hd__nand2b_2_19 (nand2b)
assign n351 = (n562 & ~(n594)); // Xsky130_fd_sc_hd__and2b_2_0 (and2b)
assign n689 = ~(n624 | n363); // Xsky130_fd_sc_hd__nor2_2_18 (nor2)
assign n747 = ~(n369 | n108_reg); // Xsky130_fd_sc_hd__nor2_2_29 (nor2)
assign n598 = ((n658) | (n266 & n610 & n714)); // Xsky130_fd_sc_hd__a31o_2_14 (a31o)
assign n443 = ((n388_reg) | (n462 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_25 (a31o)
assign n727 = (n750 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_14 (or3)
assign n746 = ((n425) | (n730 & n68_reg & n8_reg)); // Xsky130_fd_sc_hd__a31o_2_6 (a31o)
assign n78 = ~(n362 ^ n124); // Xsky130_fd_sc_hd__xnor2_2_10 (xnor2)
assign n119 = ~(n101_reg ^ n269); // Xsky130_fd_sc_hd__xnor2_2_21 (xnor2)
assign n750 = (~(n8_reg) & n68_reg & ~(n6_reg) & n73_reg); // Xsky130_fd_sc_hd__and4bb_2_4 (and4bb)
assign n210 = n44; // Xsky130_fd_sc_hd__clkbuf_8_12 (clkbuf)
assign n436 = ~((n6_reg) & (n8_reg | n73_reg)); // Xsky130_fd_sc_hd__o21ai_2_5 (o21ai)
assign n469 = ~(n8_reg & n73_reg & n68_reg); // Xsky130_fd_sc_hd__nand3_2_1 (nand3)
assign n670 = (n17 ? n243 : n160); // Xsky130_fd_sc_hd__mux2_1_1 (mux2)
assign n362 = ((n254) | (n54 & n664)); // Xsky130_fd_sc_hd__a21o_2_5 (a21o)
assign n702 = ~((n186 | n330 | n745) & (n332 | n68_reg)); // Xsky130_fd_sc_hd__o32ai_2_0 (o32ai)
assign n751 = (n679 | n619); // Xsky130_fd_sc_hd__or2_2_6 (or2)
assign n188 = ((~(n373)) & (n51 | n553)); // Xsky130_fd_sc_hd__o21ba_2_0 (o21ba)
assign n87 = (n261_reg & ~(n638_reg)); // Xsky130_fd_sc_hd__and2b_2_1 (and2b)
assign n479 = (n66_reg | n63_reg | ~(n65_reg) | ~(n62_reg)); // Xsky130_fd_sc_hd__or4bb_2_0 (or4bb)
assign n55 = ~(n180 | n724); // Xsky130_fd_sc_hd__nor2_2_19 (nor2)
assign n42 = ((n72) | (n71 & n8_reg & n69)); // Xsky130_fd_sc_hd__a31o_2_15 (a31o)
assign n642 = ~(n21 & I & n432 & n493_reg); // Xsky130_fd_sc_hd__nand4_2_10 (nand4)
assign n633 = (n596 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_15 (or3)
assign n725 = ((n316) | (n113_reg & n136_reg & n114_reg)); // Xsky130_fd_sc_hd__a31o_2_7 (a31o)
assign n740 = ~(n267_reg ^ n748); // Xsky130_fd_sc_hd__xnor2_2_22 (xnor2)
assign n378 = ~(n35_reg ^ n551); // Xsky130_fd_sc_hd__xnor2_2_11 (xnor2)
assign n94 = (~(n140_reg) & n222_reg & ~(n217_reg) & n550_reg); // Xsky130_fd_sc_hd__and4bb_2_5 (and4bb)
assign n340 = n44; // Xsky130_fd_sc_hd__clkbuf_8_13 (clkbuf)
assign n512 = ~(~(n146) | n21 | n37); // Xsky130_fd_sc_hd__nor3b_2_0 (nor3b)
assign n228 = (n74 ? n611 : n751); // Xsky130_fd_sc_hd__mux2_1_2 (mux2)
assign n735 = ((n73_reg) | (n662 & n472)); // Xsky130_fd_sc_hd__a21o_2_6 (a21o)
assign n177 = (I | n599_reg); // Xsky130_fd_sc_hd__or2_2_7 (or2)
assign n744 = ((~(n93)) & (success_reg | n116_reg)); // Xsky130_fd_sc_hd__o21ba_2_1 (o21ba)
assign n85 = (n404_reg & ~(n696_reg)); // Xsky130_fd_sc_hd__and2b_2_2 (and2b)
assign n356 = ~((n51 | n504 | n79) & (n74)); // Xsky130_fd_sc_hd__o31ai_2_0 (o31ai)
assign n653 = ((n448_reg) | (n103 & I & n21)); // Xsky130_fd_sc_hd__a31o_2_16 (a31o)
assign n592 = ~(n21 & I & n501 & n383_reg); // Xsky130_fd_sc_hd__nand4_2_11 (nand4)
assign n736 = (n442 | n29 | n31); // Xsky130_fd_sc_hd__or3_2_16 (or3)
assign n368 = ((n136_reg) | (n108_reg & n58 & n21)); // Xsky130_fd_sc_hd__a31o_2_8 (a31o)
assign n265 = ~(n101_reg ^ n147); // Xsky130_fd_sc_hd__xnor2_2_23 (xnor2)
assign n58 = (~(n66_reg) & n62_reg & ~(n63_reg) & n65_reg); // Xsky130_fd_sc_hd__and4bb_2_6 (and4bb)
assign n690 = ~(n66_reg ^ n21); // Xsky130_fd_sc_hd__xnor2_2_12 (xnor2)
assign n273 = n44; // Xsky130_fd_sc_hd__clkbuf_8_14 (clkbuf)
assign n663 = ~(~(n73_reg) | n68_reg | n8_reg); // Xsky130_fd_sc_hd__nor3b_2_1 (nor3b)
assign n286 = n44; // Xsky130_fd_sc_hd__clkbuf_8_0 (clkbuf)
assign n295 = (n189 ? n749 : n397); // Xsky130_fd_sc_hd__mux2_1_3 (mux2)
assign n739 = ((n597) | (n68_reg & n730)); // Xsky130_fd_sc_hd__a21o_2_7 (a21o)
endmodule
