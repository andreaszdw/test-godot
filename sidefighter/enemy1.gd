extends RigidBody2D


func init(v):
	var velocity = Vector2(360, 0)
	set_linear_velocity(velocity.rotated(3.14159) / v)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func hitted(h, type):
	print("I'm hitted")
