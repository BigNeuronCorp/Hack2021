extends Area2D

const speed = 1000
var motion2 = Vector2()
var direction = 1
var sprite = ""
var frames = 0
var hit_health = 25

func hit_strength(hit):
	hit_health = hit

func has_powerup(change):
	sprite = change

func set_kn_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion2.x = speed*delta * direction
	$AnimatedSprite.play(sprite)
	translate(motion2)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_kunai_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.is_in_group("Enemies"):
		body.is_hit(hit_health)
	queue_free()
