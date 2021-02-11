extends Area2D

const speed = 100
var motion = Vector2(100,0)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physis_process(delta):
	motion.x = speed*delta
	translate(Vector2(100,0))
