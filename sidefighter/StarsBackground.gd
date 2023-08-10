extends ParallaxBackground

func _process(delta):
	print(delta)
	scroll_offset.x -= 50 * delta
