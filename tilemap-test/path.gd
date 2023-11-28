extends Node2D

var points

func _draw():
	draw_multiline(points, Color.BURLYWOOD, 2)
	#draw_polyline(points, Color.BURLYWOOD, 2)
