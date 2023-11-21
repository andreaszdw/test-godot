extends Node2D

@export var soldier: PackedScene

var tilemap
var scroll_speed = 200
var window_width
var window_height
var max_scroll = Vector2(0, 0)
var zoom = 0
var min_zoom = 0.2
var max_zoom = 2.5
var zoom_speed = 5
var dragging_start_pos = Vector2(0, 0)
var dragging_event_pos = Vector2(0, 0)
var dragging_screen_start_pos = Vector2(0, 0)
var dragging = false

func _ready():
	var window_size = get_window().get_size()
	window_width = window_size.x
	window_height = window_size.y
	var level = load("res://level_6.tscn")
	tilemap = level.instantiate()	
	add_child(tilemap)
	$SpawnTimer.start()

	# calculate the max_scroll borders
	var used_rect = tilemap.get_used_rect()

	max_scroll.x = used_rect.size.x * tilemap.tile_set.tile_size.x
	max_scroll.y = used_rect.size.y * tilemap.tile_set.tile_size.y
	
#	var s = soldier.instantiate()
#	add_child(s)
#
#	var s_spawn_location = tilemap.get_SoldierSpawnLocation()
#	s_spawn_location.progress_ratio = randf()
#	s.position = s_spawn_location.position
#
#	var s_target_A_location = tilemap.get_SoldierTargetALocation()
#	s_target_A_location.progress_ratio = randf()
#	s.set_movement_target(s_target_A_location.position)
#
#	print(s_spawn_location.position, " ", s_target_A_location.position)
	
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	
	var scroll = Vector2(0, 0)

	# scrolling x, faster and slower
	if mouse_pos.x < 40:
		scroll.x = -scroll_speed * delta

	if mouse_pos.x < 15 and mouse_pos.x >= 0:
		scroll.x = -scroll_speed * 3 * delta
	
	if mouse_pos.x < 0:
		scroll.x = 0
		scroll.y = 0

	if mouse_pos.x > window_width - 40:
		scroll.x = scroll_speed * delta

	if mouse_pos.x > window_width - 15 and mouse_pos.x <= window_width:	
		scroll.x = scroll_speed * 3 * delta
		
	if mouse_pos.x > window_width:
		scroll.x = 0
		scroll.y = 0

	# scrolling y, faster and slower
	if mouse_pos.y < 40:
		scroll.y = -scroll_speed * 3 * delta

	if mouse_pos.y < 15 and mouse_pos.y >= 0:
		scroll.y = -scroll_speed * delta
		
	if mouse_pos.y < 0:
		scroll.x = 0
		scroll.y = 0

	if mouse_pos.y > window_height - 40:
		scroll.y = scroll_speed * 3 * delta

	if mouse_pos.y > window_height - 15 and mouse_pos.y <= window_height:
		scroll.y = scroll_speed * delta
		
	if mouse_pos.y > window_height:
		scroll.x = 0
		scroll.y = 0
	
	# dragging
	if dragging:
		if dragging_event_pos != Vector2(0, 0):
			var tmpDrag = dragging_start_pos - dragging_event_pos
			$MapCam.position = tmpDrag / $MapCam.zoom + dragging_screen_start_pos
	
	# zooming
	var tmpZoom = $MapCam.zoom + Vector2(zoom, zoom) * delta
	if tmpZoom.x < min_zoom:
		tmpZoom = Vector2(min_zoom, min_zoom)
	if tmpZoom.x > max_zoom:
		tmpZoom = Vector2(max_zoom, max_zoom)
		
	$MapCam.zoom = tmpZoom
	zoom = 0
		
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
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = zoom_speed
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = -zoom_speed
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if not dragging and event.pressed:
				dragging_start_pos = event.position
				dragging_screen_start_pos = $MapCam.position
				dragging = true
			if dragging and not event.pressed:
				dragging_event_pos = Vector2(0, 0)
				dragging = false
		
	if event is InputEventMouseMotion:
		if dragging:
			dragging_event_pos = event.position
			


func _on_spawn_timer_timeout():
	var s = soldier.instantiate()
	add_child(s)

	var s_spawn_location = tilemap.get_SoldierSpawnLocation()
	s_spawn_location.progress_ratio = randf()
	s.position = s_spawn_location.position

	var s_target_A_location = tilemap.get_SoldierTargetALocation()
	s_target_A_location.progress_ratio = randf()
	s.set_movement_target(s_target_A_location.position)
	
