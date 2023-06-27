extends Area2D

var energy = 100
var speed = 100
var direction = Vector2(-1, 0)
	
func _physics_process(delta):
	position += direction * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_enemy1_area_entered(area):
	energy -= area.energy
	
