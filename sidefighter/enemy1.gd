extends Area2D

var energy = 100
var value = 100
var speed = 100
var direction = Vector2(-1, 0)

var id = "enemy"
	
func _physics_process(delta):
	position += direction * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func hitted(object):
	energy -= object.energy
	if object.id != "player":
		$"../HUD".addScore(object.energy)
	if energy <= 0:
		$"../HUD".addScore(value)
		queue_free()
