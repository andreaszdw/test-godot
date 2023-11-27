extends Node2D

@export var soldier: PackedScene

var level
var tilemap

var army = []
	
func _ready():	
	# load tilemap
	var level = load("res://level_6.tscn")
	tilemap = level.instantiate()	
	add_child(tilemap)
	
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
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var pressed_position = get_global_mouse_position()
				for s in army:
					if s.mouse_over:
						if not s.selected:
							if not Input.is_key_pressed(KEY_SHIFT):
								for n in army:
									n.deselect()
							s.select()
						else:
							s.deselect()
					if s.selected:
						if not Input.is_key_pressed(KEY_SHIFT):
							s.set_movement_target(pressed_position)
	
func _on_spawn_timer_timeout():
	var s = soldier.instantiate()
	add_child(s)

	var s_spawn_location = tilemap.get_SoldierSpawnLocation()
	s_spawn_location.progress_ratio = randf()
	s.position = s_spawn_location.position

	var s_target_A_location = tilemap.get_SoldierTargetALocation()
	s_target_A_location.progress_ratio = randf()
	s.set_movement_target(s_target_A_location.position)
