extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#set_zoom(Vector2(0.5, 0.5))
	self.global_position.x = 640
	print(get_zoom())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
