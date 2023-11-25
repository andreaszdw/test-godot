extends Camera2D

var window_width
var window_height
var window_half_width
var window_half_height
var scroll_speed = 200
var max_scroll = Vector2(0, 0)

var min_zoom = 0.2
var max_zoom = 2.5
var zoom_speed = 3
var to_zoom = 0
var zooming = false

var dragging_start_pos = Vector2(0, 0)
var dragging_event_pos = Vector2(0, 0)
var dragging_screen_start_pos = Vector2(0, 0)
var dragging = false

func _ready():
	# get window size
	var window_size = get_window().get_size()
	window_width = window_size.x
	window_height = window_size.y
	window_half_width = window_width * 0.5
	window_half_height = window_height * 0.5
	
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
		scroll.y = -scroll_speed  * delta

	if mouse_pos.y < 15 and mouse_pos.y >= 0:
		scroll.y = -scroll_speed * 3 * delta
		
	if mouse_pos.y < 0:
		scroll.x = 0
		scroll.y = 0

	if mouse_pos.y > window_height - 40:
		scroll.y = scroll_speed  * delta

	if mouse_pos.y > window_height - 15 and mouse_pos.y <= window_height:
		scroll.y = scroll_speed * 3 * delta
		
	if mouse_pos.y > window_height:
		scroll.x = 0
		scroll.y = 0
	
	# dragging
	if dragging:
		if dragging_event_pos != Vector2(0, 0):
			var tmpDrag = dragging_start_pos - dragging_event_pos
			position = tmpDrag / zoom + dragging_screen_start_pos
	
	# zooming
	if zooming:
		var new_zoom = zoom + Vector2(to_zoom, to_zoom) * delta
		if new_zoom.x < min_zoom:
			new_zoom = Vector2(min_zoom, min_zoom)
		if new_zoom.x > max_zoom:
			new_zoom = Vector2(max_zoom, max_zoom)
		zoom = new_zoom
		zooming = false
		to_zoom = 0
		
	# scroll it
	position += scroll	

	# check srolling borders
	if position.x < 0:
		position.x = 0
	
	if position.x > max_scroll.x:
		position.x = max_scroll.x

	if position.y < 0:
		position.y = 0

	if position.y > max_scroll.y:
		position.y = max_scroll.y

func _input(event):	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			to_zoom = zoom_speed
			zooming = true
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			to_zoom = -zoom_speed
			zooming = true
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if not dragging and event.pressed:
				dragging_start_pos = event.position
				dragging_screen_start_pos = position
				dragging = true
			if dragging and not event.pressed:
				dragging_event_pos = Vector2(0, 0)
				dragging = false
		
	if event is InputEventMouseMotion:
		if dragging:
			dragging_event_pos = event.position

func screen_to_world_position(pos):
	var world_pos = pos - Vector2(window_half_width, window_half_height)
	world_pos /= zoom
	world_pos += get_screen_center_position()
	return world_pos
	
func set_max_scroll(x, y):
	max_scroll.x = x
	max_scroll.y = y
