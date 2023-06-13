extends RigidBody2D

var life = 100

func _ready():
	$AnimatedSprite.playing = true

func scale(s):
	$AnimatedSprite.scale.x = s
	$AnimatedSprite.scale.y = s
	$CollisionShape2D.scale.x = s
	$CollisionShape2D.scale.y = s
	life *= s

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func hitted(h):
	life -= h
	if life <= 0:
		queue_free()
