extends Node

func _ready():
	pass

func play(sound):
	print(sound)
	get_node("beam").play()
