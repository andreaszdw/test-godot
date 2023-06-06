extends RigidBody2D
	
func _ready():
	$AnimatedSprite.playing = true

func scale(s):
	$AnimatedSprite.scale.x = s
	$AnimatedSprite.scale.y = s
	$CollisionShape2D.scale.x = s
	$CollisionShape2D.scale.y = s

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
