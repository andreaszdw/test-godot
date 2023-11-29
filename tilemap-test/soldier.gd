extends CharacterBody2D

var ani_sprite
var navi_agent
var speed = 3000.0
var mouse_over = false
var selected = false

func _ready():
	ani_sprite = $AnimatedSprite2D
	navi_agent = $NavigationAgent2D
	navi_agent.path_desired_distance = 20.0
	navi_agent.target_desired_distance = 100.0
	navi_agent.debug_enabled = true
	
func _input(event):
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	if navi_agent.is_navigation_finished():
		$AnimatedSprite2D.play("standing")
		return
	
	$AnimatedSprite2D.play("walking")
	var current_agent_position = global_position
	var next_path_position = navi_agent.get_next_path_position()
	look_at(next_path_position)

	var new_velocity = current_agent_position.direction_to(next_path_position) * speed * delta
	$NavigationAgent2D.set_velocity(new_velocity)
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
	$Cursor.visible = true
	
func deselect():
	selected = false
	$Cursor.visible = false
	
func set_movement_target(mt):
	navi_agent.target_position = mt
	
