extends Area2D

signal shoot(bullet, position)

#var Bullet = preload("res://bullets/Bullet1.tscn")
export(PackedScene) var bullet1_scene

#var data_file = File.new()
#if data_file.open("res://data.json", File.READ) != OK:
#	return
#var data_text = data_file.get_as_text()
#data_file.close()
#var data_parse = JSON.parse(data_text)
#if data_parse.error != OK:
#	return
#var data = data_parse.result
#$Label.text = data["1"].name


var leftDown = false

var screen_size

var life = 1000

func _ready():
	# read json file
	var json_file = File.new()
	if json_file.open("res://jsons//test.json", File.READ) != OK:
		print("error reading file")
		return
	var json_text = json_file.get_as_text()
	json_file.close()
	var json_parse = JSON.parse(json_text)
	
	if json_parse.error != OK:
		print("error jsons parse")
		return
	var data = json_parse.result
	
	for i in data.level2.bullets:
		print(i.y)
		print(i.x)
		print(i.speed)
		print(i.direction[0])
		print(i.direction[1])
		print(i.hit)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	screen_size = get_viewport_rect().size
	
# warning-ignore:unused_argument
func _process(delta):
	if leftDown:
		if life > 0:
			emit_signal("shoot", bullet1_scene, position)

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
		death()

func death():
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
