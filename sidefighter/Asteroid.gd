extends RigidBody2D

var energy = 100
var value = 100
var ground = 100

func _physics_process(delta):
	pass
	
func init(v):
	value = ground * v
	scale(v)
	var velocity = Vector2(360, 0)
	set_linear_velocity(velocity.rotated(3.14159) / v)
	mass = 1 * v
	weight = 1 * v
	
func scale(s):
	$AnimatedSprite.scale.x = s
	$AnimatedSprite.scale.y = s
	$CollisionShape2D.scale.x = s
	$CollisionShape2D.scale.y = s
	energy = ground * s

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func hitted(object):
	energy -= object.energy
	if object.id != "player":
		$"../HUD".addScore(object.energy)
	scale(energy/ground)
	if energy <= 20:
		$"../HUD".addScore(value)
		queue_free()
