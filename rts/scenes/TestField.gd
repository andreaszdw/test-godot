extends Node2D

export(PackedScene) var soldier_scene

var test_soldier
var target_position = Vector2.ZERO

func _ready():
	test_soldier = soldier_scene.instance()
	test_soldier.position.x = 100
	test_soldier.position.y = 100 
	add_child(test_soldier)

func _process(delta):
	var direction =  target_position - test_soldier.position
	test_soldier.rotation_degrees = rad2deg(direction.angle())

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		target_position = event.position
		test_soldier.position = Vector2(300, 300)
		test_soldier.setAnimation("walk")
	
	elif event is InputEventMouseMotion:
		pass
	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport_rect().size)
