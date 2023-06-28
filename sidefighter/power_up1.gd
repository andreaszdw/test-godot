extends Area2D

var player
var direction = Vector2.ZERO
var speed = 100
var rng = RandomNumberGenerator.new()
var energy = 0
var area_name = "power_up"
func set_Player(p):
	player = p
	
func _ready():
	$LifeTimer.start()
	$DirectionTimer.start()
	rng.randomize()
	direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
	
func _physics_process(delta):
	position += direction * speed * delta
	
func _process(delta):
	var vp = get_viewport().get_visible_rect().size

	if position.x < 50:
		direction.x *= -1

	if position.x > vp.x - 50:
		direction.x *= -1
	
	if position.y < 50:
		direction.y *= -1
		
	if position.y > vp.y - 50:
		direction.y *= -1


func _on_LifeTimer_timeout():
	queue_free()	

func _on_DirectionTimer_timeout():
	direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))

func _on_power_up1_area_entered(area):
	if area == player:
		player.increment_shoot()
		queue_free()
