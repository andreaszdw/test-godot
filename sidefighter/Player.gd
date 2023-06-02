extends Area2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	if event is InputEventMouseMotion:
		 position = event.position
