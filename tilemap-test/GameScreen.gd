extends Node2D

var level
var tilemap
var rid_tilemap
var Draw

var army = []
var paths = []
var way_points = []
	
func _ready():
	
	# load tilemap
	level = load("res://level_6.tscn")
	tilemap = level.instantiate()	
	add_child(tilemap)
	rid_tilemap = tilemap.get_navigation_map(0)
	
	var used_rect = tilemap.get_used_rect()
	var tmp_x = used_rect.size.x * tilemap.tile_set.tile_size.x
	var tmp_y = used_rect.size.y * tilemap.tile_set.tile_size.y
	
	$MapCam.set_max_scroll(tmp_x, tmp_y)
	
	for n in range(3):
		var s = load("res://Soldier.tscn").instantiate()
		add_child(s)
		s.position = Vector2(350, 300 + n * 10)
		army.append(s)
	
func _process(delta):
	var mp = get_global_mouse_position()
	for p in paths:
		p.delete()
		
	paths.clear()
	
func _input(event):
	var mp = get_global_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				for s in army:
					if s.mouse_over:
						if Input.is_key_pressed(KEY_SHIFT):
							if s.selected:
								s.deselect()
							else:
								s.select()
						else:
							if not s.selected:
								for n in army:
									n.deselect()
								s.select()
							else:
								if s.selected:
									for n in army:
										n.deselect()
				for s in army:
					if s.selected:
						if not Input.is_key_pressed(KEY_SHIFT):
							s.set_movement_target(mp)
	
