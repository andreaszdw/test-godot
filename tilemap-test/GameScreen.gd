extends Node2D

var tilemap
var scroll_speed = 200
var window_width
var window_height
var max_scroll = Vector2(0, 0)

func _ready():
	var window_size = get_window().get_size()
	window_width = window_size.x
	window_height = window_size.y
	var level = load("res://Level3.tscn")
	tilemap = level.instantiate()	
	add_child(tilemap)

	# calculate the max_scroll borders
	var used_rect = tilemap.get_used_rect()

	max_scroll.x = used_rect.size.x * tilemap.tile_set.tile_size.x
	max_scroll.y = used_rect.size.y * tilemap.tile_set.tile_size.y
	
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var scroll = Vector2(0, 0)

	# scrolling x, faster and slower
	if mouse_pos.x < 40:
		scroll.x = -scroll_speed * delta

	if mouse_pos.x < 15 and mouse_pos.x >= 0:
		scroll.x = -scroll_speed * 3 * delta

	if mouse_pos.x > window_width - 40:
		scroll.x = scroll_speed * delta

	if mouse_pos.x > window_width - 15 and mouse_pos.x <= window_width:	
		scroll.x = scroll_speed * 3 * delta

	# scrolling y, faster and slower
	if mouse_pos.y < 40:
		scroll.y = -scroll_speed * 3 * delta

	if mouse_pos.y < 15 and mouse_pos.y >= 0:
		scroll.y = -scroll_speed * delta

	if mouse_pos.y > window_height - 40:
		scroll.y = scroll_speed * 3 * delta

	if mouse_pos.y > window_height - 15 and mouse_pos.y <= window_height:
		scroll.y = scroll_speed * delta

	# scroll it
	$MapCam.position += scroll	

	# check srolling borders
	if $MapCam.position.x < 0:
		$MapCam.position.x = 0

	if $MapCam.position.x > max_scroll.x:
		$MapCam.position.x = max_scroll.x

	if $MapCam.position.y < 0:
		$MapCam.position.y = 0

	if $MapCam.position.y > max_scroll.y:
		$MapCam.position.y = max_scroll.y
	pass
		
func _input(event):
	#print(event.as_text())
	pass
