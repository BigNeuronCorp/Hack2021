extends 	KinematicBody2D

const ground = Vector2(0,-1)
var on_ground = false
const gravity = 60
const maxfallspeed = 800
var maxspeed = 800
const jumpspeed = -1400
var motion = Vector2()
var position_player = Vector2(0,0)
var hp = 100
var last_hp = 100 
var dead = false
var last_anim = false
var play_music = false
var selsprite = "vaccine"
var powerup = 0
var frame_2 = 0
var score_value = 0
var update = false

export var firedelay = 0.2


onready var health = get_node("life_bar")

onready var pause = get_node("pause")
onready var gameover = get_node("game_over")

onready var life_box = get_node("life_box")
onready var death_box = get_node("death_box")

onready var score = get_node("CanvasLayer/ui/scoreboard")

onready var bg_music = get_node("sound_on_playing/background")
onready var jump_sound = get_node("sound_on_playing/jump")
onready var run_sound = get_node("sound_on_playing/run")
onready var shoot_sound = get_node("sound_on_playing/shoot")
onready var death_sound = get_node("sound_on_playing/death")

var vaccine = preload("res://vaccine/vaccine.tscn")



func has_powerup(power):
	selsprite = power

func is_hit_by_enemy(hit):
	hp-=hit

func _physics_process(_delta):
	if selsprite == "vaccine_2":
		frame_2 += 1
		if frame_2 == 600:
			selsprite = "vaccine"
			frame_2 = 0
	
	if play_music == false and dead == false:
		bg_music.play()
		play_music = true
	
	elif dead == true:
		bg_music.stop()
		
	if hp > 0 and dead == false:
		life_box.set_disabled(false)
		death_box.set_disabled(true)
		
		if Input.is_action_pressed("ui_right"):
			
			if on_ground == true:
				if run_sound.is_playing() == false:
					run_sound.play()
			else:
				run_sound.stop()
		
			motion.x = maxspeed
			$AnimatedSprite.play("doctor_run")
			$AnimatedSprite.flip_h = false
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *=-1
			
		elif Input.is_action_pressed("ui_left"):
			if on_ground == true:
				if run_sound.is_playing() == false:
					run_sound.play()
			else:
				run_sound.stop()

			motion.x = -maxspeed    
			$AnimatedSprite.play("doctor_run") 
			$AnimatedSprite.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *=-1		
		else:
			motion.x = 0
			run_sound.stop()
			if on_ground == true:
				$AnimatedSprite.play("doctor_idle_aim")
			
			
		if Input.is_action_pressed("ui_select"):
			if jump_sound.is_playing() == false:
				run_sound.stop()
				jump_sound.play()
			if on_ground == true:
				motion.y = jumpspeed
				on_ground = false

		
		if Input.is_action_pressed("ui_focus_next") and $cooldown.is_stopped():
			shoot_sound.play()
			$cooldown.start(firedelay)
			var v = vaccine.instance()
			if selsprite == "vaccine_2":
				v.hit_strength(50)
				maxspeed = 1200
			else:
				v.hit_strength(25)
				maxspeed = 800
			if sign($Position2D.position.x) == 1:
				v.set_kn_direction(1)
			else:
				v.set_kn_direction(-1)
			v.has_powerup(selsprite)
			get_parent().add_child(v)
			v.position = $Position2D.global_position
			
		if Input.is_action_just_pressed("ui_cancel"):
			pause._pause(true)



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
		death_sound.play()
		$AnimatedSprite.play("doctor_dead")
		motion.x = 0
		motion.y = -200
		life_box.set_disabled(true)
		death_box.set_disabled(false)
	
		dead = true
	
	else:
		if !is_on_floor():
			motion.y += gravity
			if motion.y > maxfallspeed:
				motion.y = maxfallspeed
		if  death_sound.is_playing() == false:
			$AnimatedSprite.stop()
			#print($AnimatedSprite.is_playing())
			
	if hp != last_hp:
		health._on_health_update(hp)
		#score._score_update(hp)
		last_hp = hp
	
			
	if $AnimatedSprite.is_playing()==false and death_sound.is_playing() == false:
		gameover._gameover(true)
		dead = false
# warning-ignore:return_value_discarded
	move_and_slide(motion, ground)
 
