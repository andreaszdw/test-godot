extends AudioStreamPlayer2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_playing():
		print("p")
		queue_free()
	
func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		print("Destroying ", name)
		
		
