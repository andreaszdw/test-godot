extends CanvasLayer


func update_life(life):
	$PlayerLife.text = str(life)


func _on_Player_hit(life):
	update_life(life)
