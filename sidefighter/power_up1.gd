extends Area2D

var id = "power_up"
var speed = 100
var energy = 0
var direction = Vector2.ZERO
var rng = RandomNumberGenerator.new()

	
func _ready():
	$LifeTimer.start()
	$WarningTimer.start()
	$DirectionTimer.start()
	rng.randomize()
	direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
	
func _physics_process(delta):
	position += direction * speed * delta
	
func _process(_delta):
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

func hitted(object):
	if object.id == "player":
		object.increment_shoot()
		queue_free()


func _on_WarningTimer_timeout():
	$BlinkTimer.start()


func _on_BlinkTimer_timeout():
	if modulate.a == 1:
		modulate.a = 0.2
	else:
		modulate.a = 1
