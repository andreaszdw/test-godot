extends CharacterBody2D

var ani_sprite
var navi_agent

func _ready():
	ani_sprite = $AnimatedSprite2D
	navi_agent = $NavigationAgent2D
	navi_agent.path_desired_distance = 2.0
	navi_agent.target_desired_distance = 2.0
	navi_agent.debug_enabled = true
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_W:
			ani_sprite.play("walking")
		else:
			ani_sprite.play("standing")
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			set_movement_target(get_global_mouse_position())
			
func set_movement_target(mt):
	navi_agent.target_position = mt
	
func _physics_process(_delta):
	if navi_agent.is_navigation_finished():
		return
		
	var current_agent_position = global_position
	var next_path_position = navi_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * 200.0
	move_and_slide()

	
