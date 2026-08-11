import pya

layout = pya.Layout()
layout.read(input)

for cell in layout.each_cell():
    print(cell.name)
