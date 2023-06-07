extends Area2D

signal hit

var hit = 10
var speed = 10


func _on_Bullet1_body_entered(body):
	body.hitted(hit)
	queue_free()
