extends Node

export(PackedScene) var asteroid_scene

var rng = RandomNumberGenerator.new()

func new_game():
	$StartTimer.start()
	
func _ready():
	rng.randomize()
	new_game()

# warning-ignore:unused_argument
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
	spawn_loc.offset = rng.randi()
	ast.position = spawn_loc.position
	ast.scale(rng.randf_range(0.2, 2))
	
	var velocity = Vector2(360, 0)
	ast.linear_velocity = velocity.rotated(3.14159)
	
	add_child(ast)
	
