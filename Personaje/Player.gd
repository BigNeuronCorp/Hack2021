extends 	KinematicBody2D

const ground = Vector2(0,-1)
var on_ground = false
const gravity = 50
const maxfallspeed = 800
const maxspeed = 600
const jumpspeed = -1200

var motion = Vector2()

func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		motion.x = maxspeed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		
	elif Input.is_action_pressed("left"):
		motion.x = -maxspeed    
		$AnimatedSprite.play("run") 
		$AnimatedSprite.flip_h = true
	else:
		motion.x = 0
		if on_ground == true:
			$AnimatedSprite.play("idle")
		
		
	if Input.is_action_pressed("jump"):
		if on_ground == true:
			motion.y = jumpspeed
			on_ground = false
				
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
 
