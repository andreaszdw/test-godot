extends RigidBody2D

var realLife = 0
var groundLife = 100
var startLife = 0
var direction = 0

func _physics_process(delta):
	position += direction * delta
	
func init(v):
	startLife = groundLife * v
	scale(v)
	
func scale(s):
	$AnimatedSprite.scale.x = s
	$AnimatedSprite.scale.y = s
	$CollisionShape2D.scale.x = s
	$CollisionShape2D.scale.y = s
	realLife = groundLife * s

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func hitted(h, type):
	realLife -= h
	if type != "ship":
		$"../HUD".addScore(h)
	scale(realLife/groundLife)
	if realLife <= 10:
		$"../HUD".addScore(startLife)
		queue_free()
