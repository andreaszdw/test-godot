extends Area2D

var Bullet = preload("res://bullets/Bullet1.tscn")
var leftDown = false

var screen_size

var life = 1000

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if leftDown:
		shoot()

func _input(event):
	if event is InputEventMouseMotion:
		position = event.position
		
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				leftDown = true	
			else:
				leftDown = false
	
	var cur = $AnimatedSprite.animation
	
	var size = $AnimatedSprite.frames.get_frame(cur, 0).get_size()
	var scale =$AnimatedSprite.scale
	var width = ProjectSettings.get_setting("display/window/size/width")
	var height = ProjectSettings.get_setting("display/window/size/height") 
	
	if position.x < size.x * 0.5 * scale.x:
		position.x = size.x * 0.5 * scale.x		
	if position.x > width - size.x * 0.5 * scale.x:
		position.x = width - size.x * 0.5 * scale.x		
	if position.y < size.y * 0.5 * scale.y:
		position.y = size.y * 0.5 * scale.y
	if position.y > height - size.y * 0.5 * scale.y:
		position.y = height - size.y * 0.5 * scale.y


func _on_Player_body_entered(body):
	life -= body.life
	body.hitted(life)
	if life <= 0:
		hide()

func shoot():
	var b = Bullet.instance()
	b.position = position
	add_child(b)

func death():
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
