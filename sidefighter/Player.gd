extends Area2D

signal shoot(bullet, position, shoot)
signal hit(life)

#var Bullet = preload("res://bullets/Bullet1.tscn")
export(PackedScene) var bullet1_scene

var leftDown = false

var screen_size

var life = 1000

var shoot = 0
var shoot_max = 4
var shoot_array = [
	"level1",
	"level2",
	"level3",
	"level4",
	"level5"
]
var shoot_data = ""

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
		print("error json parse")
		return
		
	shoot_data = json_parse.result
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	screen_size = get_viewport_rect().size
	
# warning-ignore:unused_argument
func _process(delta):
	if leftDown:
		if life > 0:
			emit_signal("shoot", bullet1_scene, position, shoot_data[shoot_array[shoot]])

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
	life -= body.realLife
	body.hitted(life, "ship")
	if life <= 0:
		death()
	emit_signal("hit", int(life))
	
func increment_shoot():
	shoot += 1
	if shoot > shoot_max:
		shoot = shoot_max	

func death():
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
