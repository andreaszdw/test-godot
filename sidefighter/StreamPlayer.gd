extends AudioStreamPlayer2D

var beam = load("res://art/sounds/beam-8-43831.mp3")

func playSound():
	print("play")
	stream = beam
	play()
