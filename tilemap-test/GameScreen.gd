extends Node2D

@export var soldier: PackedScene
@export var possible_path: PackedScene

var level
var tilemap
var rid_tilemap
var Draw

var army = []
var paths = []
	
func _ready():	
	# load tilemap
	var level = load("res://level_6.tscn")
	tilemap = level.instantiate()	
	add_child(tilemap)
	rid_tilemap = tilemap.get_navigation_map(0)
	
	var used_rect = tilemap.get_used_rect()
	var tmp_x = used_rect.size.x * tilemap.tile_set.tile_size.x
	var tmp_y = used_rect.size.y * tilemap.tile_set.tile_size.y
	
	$MapCam.set_max_scroll(tmp_x, tmp_y)
	
	for x in range(10):
		var s = soldier.instantiate()
		add_child(s)
		s.position = Vector2(300 + x* 20, 300)
		army.append(s)
	#$SpawnTimer.start()
	
func _process(delta):
	queue_redraw()
	
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
							
func _draw():
	var mp = get_global_mouse_position()
	for p in paths:
		remove_child(p)
	paths = []
	for s in army:
		if s.selected:
			var tmp_path = NavigationServer2D.map_get_path(rid_tilemap, s.position, mp, true)
			var pp = possible_path.instantiate()
			pp.points = tmp_path
			add_child(pp)
			paths.append(pp)
	
func _on_spawn_timer_timeout():
	var s = soldier.instantiate()
	add_child(s)

	var s_spawn_location = tilemap.get_SoldierSpawnLocation()
	s_spawn_location.progress_ratio = randf()
	s.position = s_spawn_location.position

	var s_target_A_location = tilemap.get_SoldierTargetALocation()
	s_target_A_location.progress_ratio = randf()
	s.set_movement_target(s_target_A_location.position)
