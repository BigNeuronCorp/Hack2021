extends KinematicBody2D

const speed = 30
const GRAVITY = 20
const jumping = -300
const Floor = Vector2(0, -1)
const bullet = preload("res://covid/EnemyBullet.tscn")
const player = preload("res://Character/Player.tscn")

var life = 100
var death = false
var trip = 0
var time = 20
var exist = false
var velocity = Vector2()
var frames = 0
var appear = 0
var score_value = 0
var hit_count = 0
var score = 0

func is_hit(health):
	life -= health
	if life <= 0:
		score = 100
		life = 0
		is_dead()

func is_dead():
	$AnimatedSprite.call_deferred("play","Death")
	death = true
	velocity = Vector2(0,0)
	$CollisionShape2D.set_deferred("disabled",true)
	$Timer.start()
	
func _process(_delta):
	if death == false:
		if exist == true:
			frames += 1
			if frames == 15 and appear == 1:
				$AnimatedSprite.flip_h =  true
			if frames> 60:
				if frames%time == 0:
					var Bullet = bullet.instance()
					var Bullet2 = bullet.instance()
					Bullet.set_bullet_direction(-1,0,0)
					Bullet2.set_bullet_direction(-1,-1,1)
					get_parent().add_child(Bullet)
					Bullet.position = $Pos_1.global_position
					get_parent().add_child(Bullet2)
					Bullet2.position = $Pos_2.global_position
					if time == 20:
						trip += 1
					elif time == 100:
						trip = 1
				elif trip == 1:
					trip = 0
					if time == 20:
						time = 100
					else:
						time= 20
			#velocity.y += GRAVITY
		else:
			$AnimatedSprite.play("Idle")
		
	
	move_and_slide(velocity, Floor)

func _on_VisibilityNotifier2D_screen_entered():
	appear += 1
	exist = true
	if death == false:
		get_node("CollisionShape2D").disabled = false


func _on_Timer_timeout():
	$AnimatedSprite.visible = not $AnimatedSprite.visible


func _on_VisibilityNotifier2D_screen_exited():
	exist = false
	get_node("CollisionShape2D").disabled = true
