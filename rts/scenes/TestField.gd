extends Node2D

export(PackedScene) var soldier_scene

var test_soldier

func _ready():
	test_soldier = soldier_scene.instance()
	test_soldier.position.x = 100
	test_soldier.position.y = 100 
	add_child(test_soldier)

func _process(delta):
	pass

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		test_soldier.position = Vector2(300, 300)
		test_soldier.setAnimation("walk")
	
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		pass
	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport_rect().size)
