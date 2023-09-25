extends Node2D

var path = []
var map 

onready var soldier = $Infantry

func _ready():
	call_deferred("setup_navserver")
	
func _process(delta):
	var walk_distance = soldier.speed * delta
	move_along_path(walk_distance)
	
func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	_update_navigation_path(soldier.position, get_local_mouse_position())
	
	
func setup_navserver():
	
	map = Navigation2DServer.map_create()
	Navigation2DServer.map_set_active(map, true)
	
	var region = Navigation2DServer.region_create()
	Navigation2DServer.region_set_transform(region, Transform())
	Navigation2DServer.region_set_map(region, map)
	
	var navigation_poly = NavigationMesh.new()
	navigation_poly = $NavigationPolygonInstance.navpoly
	Navigation2DServer.region_set_navpoly(region, navigation_poly)
	
	yield(get_tree(), "physics_frame")
	
func move_along_path(distance):
	var last_point = soldier.position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		
		soldier.rotation_degrees = rad2deg((path[0] - position).angle())
		soldier.setAnimation("walk")
		

		# The position to move to falls between two points.
		if distance <= distance_between_points:
			soldier.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# The character reached the end of the path.
	soldier.position = last_point
	soldier.setAnimation("stand")
	set_process(false)


func _update_navigation_path(start_position, end_position):
	# map_get_path is part of the avigation2DServer class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = Navigation2DServer.map_get_path(map,start_position, end_position, true)
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	set_process(true)
