extends GridMap

var tiles = [
	[88, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0],
	[1, 0, 0, 0, 0, 0, 0, 99]
]

func _ready():
	var w = 8
	var h = 8
	
	for y in range(h):
		print(y)
	#	for x in range(w):
	#		print(tiles[y][x])
	
	print(tiles[7][7])
	
	print(mesh_library.get_item_list())
	set_cell_item(0, 0, 0, 1)
	set_cell_item(0, 0, 2, 0)
	set_cell_item(0, 0, 4, 1)
	set_cell_item(2, 0, 2, 2)
	set_cell_item(-2, 0, 2, 2)
