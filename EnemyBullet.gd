extends Area2D

var velocity = Vector2()
const speed = 600
var direction_x = 1
var direction_y = 1
var angled = 0

func _ready():
	pass 

func set_bullet_direction(dirx,diry,angle):
	direction_x = dirx
	direction_y = diry
	angled = angle

func _process(delta):
	velocity.x = speed * delta * direction_x
	if angled == 1:
		velocity.y = speed * delta * 0.15 * direction_y
	elif angled == 0:
		velocity.y = speed * delta * 0
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_EnemyBullet_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == "Player":
		body.is_hit_by_enemy(10)
		queue_free()
