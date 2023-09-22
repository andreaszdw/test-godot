extends Area2D

var speed = 20.0 # pixel per second
var destination = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	#print((destination-position).length())
	if (destination-position).length() > 2:
		var direction = destination - position
		rotation_degrees = rad2deg((destination - position).angle())
		$AnimatedSprite.animation = "walk"
		position += direction.normalized() * speed * delta
	else:
		$AnimatedSprite.animation = "stand"
	
func setAnimation(ani):
	$AnimatedSprite.animation = ani
	
func setDestination(v):
	destination = v

func setPosition(v):
	position = v
