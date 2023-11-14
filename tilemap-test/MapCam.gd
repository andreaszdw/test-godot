extends Camera2D

var tilemap

func _ready():
	print(tilemap)
	set_position(Vector2(600, 400))
	
func _process(delta):
	print(get_screen_center_position())
	
