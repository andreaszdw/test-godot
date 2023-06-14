extends Node

export(PackedScene) var asteroid_scene

var rng = RandomNumberGenerator.new()
var canShoot = true

func new_game():
	$StartTimer.start()
	$ShootTimer.wait_time = 0.1
	
func _ready():
	rng.randomize()
	new_game()

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen)

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

func _on_Player_shoot(bullet, position):
	if canShoot:
		var b = bullet.instance()
		add_child(b)
		b.position = position
		b.position.y += 10
		var b2 = bullet.instance()
		add_child(b2)
		b2.position = position
		b2.position.y -= 10
		$ShootTimer.start()
		canShoot = false

func _on_ShootTimer_timeout():
	canShoot = true
