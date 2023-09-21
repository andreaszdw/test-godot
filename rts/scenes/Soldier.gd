extends Area2D

func _ready():
	#$AnimatedSprite.animation = "walk"
	pass

func _process(delta):
	pass
	
func setAnimation(ani):
	$AnimatedSprite.animation = ani
