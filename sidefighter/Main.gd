extends Node

export(PackedScene) var asteroid_scene
export(PackedScene) var power_up_scene
export(PackedScene) var enemy1_scene

var rng = RandomNumberGenerator.new()
var canShoot = true

func game_over():
	$AsteroidTimer.stop()
	$PowerUpTimer.stop()
	$EnemyTimer.stop()
	
func new_game():
	get_tree().call_group("asteroids", "queue_free")
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	$Player.start()
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
	$PowerUpTimer.start()
	$EnemyTimer.start()
	
func _on_AsteroidTimer_timeout():
	var ast = asteroid_scene.instance()	
	var spawn_loc = get_node("SpawnPath/SpawnPathLocation")
	spawn_loc.offset = rng.randi()
	ast.position = spawn_loc.position
	ast.init(rng.randf_range(0.4, 2))	
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

func _on_PowerUpTimer_timeout():
	var spawn_loc = get_node("SpawnPowerUp/SpawnPowerUpLocation")
	spawn_loc.offset = rng.randi()
	var pu1 = power_up_scene.instance()
	pu1.position = spawn_loc.position
	add_child(pu1)

func _on_EnemyTimer_timeout():
	var enemy = enemy1_scene.instance()
	var spawn_loc = get_node("SpawnPath/SpawnPathLocation")
	spawn_loc.offset = rng.randi()
	enemy.position = spawn_loc.position
	add_child(enemy)	
	
