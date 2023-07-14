extends Node

func _ready():
	pass

func play(sound):
	var ns = get_node("beam")
	
	$AudioStreamPlayer.play
