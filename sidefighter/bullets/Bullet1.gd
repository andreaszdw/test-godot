extends Area2D

var id = "player_bullet"
var energy = 50
var speed = 1000
var direction = Vector2(1, 0)

func _ready():
	SoundManager.play_beam()
	
	
func _physics_process(delta):
	position += direction * speed * delta

func _on_Bullet1_body_entered(body):
	body.hitted(self)
	queue_free()

func _on_Bullet1_area_entered(area):
	var a_id = area.id	
	if a_id == "player":
		return
	if a_id == "player_bullet":
		return
	if a_id == "power_up":
		return
		
	area.hitted(self)		
	queue_free()
	
func hitted(_object):
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
