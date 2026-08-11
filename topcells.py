import pya

layout = pya.Layout()
layout.read(input)

for cell in layout.top_cells():
    print(cell.name)
