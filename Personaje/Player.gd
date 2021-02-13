extends 	KinematicBody2D

const ground = Vector2(0,-1)
var on_ground = false
const gravity = 50
const maxfallspeed = 800
const maxspeed = 1500
const jumpspeed = -1800
var motion = Vector2()
var hp = 100
var last_hp = 100 
var dead = false
var last_anim = false

export var firedelay = 0.2


onready var health = get_node("life_bar")

var vaccine = preload("res://vaccine/vaccine.tscn")



func _physics_process(_delta):
		
	if hp > 0 and dead == false:
		if Input.is_action_pressed("ui_right"):
			motion.x = maxspeed
			$AnimatedSprite.play("doctor_run")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *=-1
			
		elif Input.is_action_pressed("ui_left"):
			motion.x = -maxspeed    
			$AnimatedSprite.play("doctor_run") 
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *=-1		
		else:
			motion.x = 0
			if on_ground == true:
				$AnimatedSprite.play("doctor_idle_aim")
			
			
		if Input.is_action_pressed("ui_select"):
			if on_ground == true:
				motion.y = jumpspeed
				on_ground = false

		
		if Input.is_action_pressed("ui_focus_next") and $cooldown.is_stopped():
			$cooldown.start(firedelay)
			var v = vaccine.instance()
			if sign($Position2D.position.x) == 1:
				v.set_kn_direction(1)
			else:
				v.set_kn_direction(-1)
			get_parent().add_child(v)
			v.position = $Position2D.global_position
			#print("disparar")
			hp = hp -10

		
					
		motion.y += gravity
		if motion.y > maxfallspeed:
			motion.y = maxfallspeed
		
		if is_on_floor():
			on_ground = true 
		else:
			on_ground = false
			if motion.y < 0:
				$AnimatedSprite.play("doctor_jump")
			else:
				$AnimatedSprite.play("doctor_jump")
				
	elif hp <= 0 and dead == false:
		#print("Mori!!")
		$AnimatedSprite.play("doctor_dead")
		motion.x = 0
		
		if on_ground == false:
			motion.y = maxfallspeed
		else:
			motion.y = 0
		#dead = true
	
	#else:
		#$AnimatedSprite.play("doctor_deadx2")
		#$AnimatedSprite.stop()
	
	if hp != last_hp:
		health._on_health_update(hp)
		last_hp = hp
	
			
			
# warning-ignore:return_value_discarded
	move_and_slide(motion, ground)
 
