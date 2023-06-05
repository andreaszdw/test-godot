extends Node

func _ready():
	print("                 [Screen Metrics]")
	print("            Display size: ", OS.get_screen_size())
	print("   Decorated Window size: ", OS.get_real_window_size())
	print("             Window size: ", OS.get_window_size())
	print("        Project Settings: Width=", ProjectSettings.get_setting("display/window/size/width"), " Height=", ProjectSettings.get_setting("display/window/size/height")) 
	print(OS.get_window_size().x)
	print(OS.get_window_size().y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen)
		print("                 [Screen Metrics]")
		print("            Display size: ", OS.get_screen_size())
		print("   Decorated Window size: ", OS.get_real_window_size())
		print("             Window size: ", OS.get_window_size())
		print("        Project Settings: Width=", ProjectSettings.get_setting("display/window/size/width"), " Height=", ProjectSettings.get_setting("display/window/size/height")) 
		print(OS.get_window_size().x)
		print(OS.get_window_size().y)
		
func _input(event):	
	if event is InputEventMouseMotion:
		#print(event.position)
		pass
