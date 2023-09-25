extends Node2D

export(PackedScene) var soldier_scene
export(PackedScene) var infantry_scene

var test_soldier
var test_infantry

func _ready():
	test_soldier = soldier_scene.instance()
	test_soldier.setPosition(Vector2(640, 400))
	add_child(test_soldier)
	
	var

func _process(delta):
	pass

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		test_soldier.setDestination(event.position)
	
	elif event is InputEventMouseMotion:
		pass
