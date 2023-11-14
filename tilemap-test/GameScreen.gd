extends Node2D

var tilemap

func _ready():
	var level = load("res://Level1.tscn")
	tilemap = level.instantiate()	
	add_child(tilemap)
	
	$MapCam.tilemap = tilemap

func _process(delta):
	pass
