extends Node

export(PackedScene) var asteroid_scene

func new_game():
	$StartTimer.start()
	
func _ready():
	randomize()
	new_game()

func _process(delta):
	if Input.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen)
		
func _input(event):	
	if event is InputEventMouseMotion:
		#print(event.position)
		pass

func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	
func _on_AsteroidTimer_timeout():
	var ast = asteroid_scene.instance()
	
	var spawn_loc = get_node("SpawnPath/SpawnPathLocation")
	spawn_loc.offset = randi()
	ast.position = spawn_loc.position
	
	var velocity = Vector2(180, 0)
	ast.linear_velocity = velocity.rotated(3.14159)
	
	add_child(ast)
	
