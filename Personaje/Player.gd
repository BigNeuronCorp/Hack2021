extends 	KinematicBody2D

const ground = Vector2(0,-1)
var on_ground = false
const gravity = 50
const maxfallspeed = 800
const maxspeed = 500
const jumpspeed = -1200
var motion = Vector2()

export var firedelay = 0.2

var kunai = preload("res://Personaje/kunai.tscn")
func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		motion.x = maxspeed
		#$AnimatedSprite.play("run")
		$AnimatedSprite.play("doctor_run")
		$AnimatedSprite.flip_h = false
		
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *=-1
		
	elif Input.is_action_pressed("left"):
		motion.x = -maxspeed    
		#$AnimatedSprite.play("run")
		$AnimatedSprite.play("doctor_run") 
		$AnimatedSprite.flip_h = true
		
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *=-1
	else:
		motion.x = 0
		if on_ground == true:
			#if Input.is_action_pressed("trigger") == false:
			#$AnimatedSprite.play("idle")
			$AnimatedSprite.play("doctor_idle")
		
		
	if Input.is_action_pressed("jump"):
		if on_ground == true:
			motion.y = jumpspeed
			on_ground = false
	
	if Input.is_action_pressed("trigger") and $cooldown.is_stopped():
		$cooldown.start(firedelay)
		var kn = kunai.instance()
		if sign($Position2D.position.x) == 1:
			kn.set_kn_direction(1)
		else:
			kn.set_kn_direction(-1)
		get_parent().add_child(kn)
		kn.position = $Position2D.global_position
			
		if on_ground == true and motion.x == 0: 

			$AnimatedSprite.play("doctor_idle")
			
		elif on_ground == true and motion.x != 0: 
			$AnimatedSprite.play("doctor_run")
	
				
	motion.y += gravity
	if motion.y > maxfallspeed:
		motion.y = maxfallspeed
	
	if is_on_floor():
		on_ground = true 
	else:
		on_ground = false
		if motion.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
			
			
# warning-ignore:return_value_discarded
	move_and_slide(motion, ground)
 
