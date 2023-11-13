extends Node2D

var tilemap

# Called when the node enters the scene tree for the first time.
func _ready():
	var level = load("res://Level1.tscn")
	tilemap = level.instantiate()
	
	add_child(tilemap)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
