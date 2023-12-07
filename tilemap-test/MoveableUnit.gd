extends CharacterBody2D

class_name MoveableUnit

@export var max_velocity = 3000.0
@export var nav_layer = 1 # 1 = land
@export var unit_name = "Moveable"

var mouse_over = false
var selected = false

func _ready():
	$NavAgent.path_desired_distance = 20.0
	$NavAgent.target_desired_distance = 100.0
	
func _input(event):
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	if $NavAgent.is_navigation_finished():
		$UnitSprite.play("default")
		return
	
	$UnitSprite.play("walking")
	var current_agent_position = global_position
	var next_path_position = $NavAgent.get_next_path_position()
	look_at(next_path_position)

	var new_velocity = current_agent_position.direction_to(next_path_position) * max_velocity * delta
	$NavAgent.set_velocity(new_velocity)
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
	
func select():
	selected = true
	$SelCur.visible = true
	
func deselect():
	selected = false
	$SelCur.visible = false
	
func set_movement_target(mt):
	$NavAgent.target_position = mt
	
func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
