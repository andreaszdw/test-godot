extends CanvasLayer

var playerFullLife = 1000
var lifeRectMaxWidth = 200
var score = 0

func update_life(life):
	var newLifeRectWidth = lifeRectMaxWidth * life / playerFullLife
	if newLifeRectWidth < 0:
		newLifeRectWidth = 0
	if newLifeRectWidth > lifeRectMaxWidth:
		newLifeRectWidth = lifeRectMaxWidth
	$LifeRectBorder/LifeRect.rect_size.x = newLifeRectWidth

func _on_Player_hit(life):
	update_life(life)

func addScore(s):
	score = score + s
	$Score.text = str(int(score))
	
