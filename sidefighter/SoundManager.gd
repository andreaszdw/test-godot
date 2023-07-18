extends Node

func play_beam():
	print("beam playing")
	var sound = preload("res://BeamSound.tscn").instance()
	sound.play()
	
