extends Area2D

signal hit

var hit = 50
var speed = 1000
var direction = Vector2(1, 0)
	
func _physics_process(delta):
	position += direction * speed * delta
	
func _process(delta):
	pass
	
func _on_Bullet1_body_entered(body):
	body.hitted(hit)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
