extends MoveableUnit

class_name SoldierUnit


func _ready():
	super()
	print("soldier")

func _process(delta):
	super(delta)
	print(delta)
