extends Area2D

const speed = 1000
var motion = Vector2()
var direction = 1

func _ready():
	pass # Replace with function body.

func set_kn_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.x = speed*delta * direction
	translate(motion)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_kunai_body_entered(body):
	queue_free()
