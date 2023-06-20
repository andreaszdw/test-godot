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
	ast.init(rng.randf_range(0.2, 2))
#
#	var velocity = Vector2(360, 0)
#	ast.set_linear_velocity(velocity.rotated(3.14159))
	#ast.direction = velocity.rotated(3.14159)
	
	add_child(ast)	

func _on_Player_shoot(bullet, position, shoot):
	if canShoot:		
		for i in shoot.bullets:
			var b = bullet.instance()
			add_child(b)
			b.position = position
			b.position.x += i.x
			b.position.y += i.y
			b.speed = i.speed
			b.energy = i.energy
			var dir = Vector2(i.direction[0], i.direction[1])
			b.direction = dir.normalized()
			
		$ShootTimer.start()
		canShoot = false

func _on_ShootTimer_timeout():
	canShoot = true
