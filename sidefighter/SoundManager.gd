extends Node

func play_beam():
	var sound = preload("res://BeamSound.tscn").instance()
	sound.play()
	
