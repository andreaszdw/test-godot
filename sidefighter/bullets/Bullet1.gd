extends Area2D

var player
var energy = 50
var speed = 1000
var direction = Vector2(1, 0)

func setPlayer(p):
	player = p
	
func _physics_process(delta):
	position += direction * speed * delta

func _on_Bullet1_body_entered(body):
	body.hitted(energy, "bullet")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	


func _on_Bullet1_area_entered(area):
	if area == player:
		print("r")
		return
