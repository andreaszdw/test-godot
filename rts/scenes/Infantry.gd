extends Area2D

var speed = 15.0 # pixel per second
var destination = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	pass
	
func setAnimation(ani):
	$AnimatedSprite.animation = ani
