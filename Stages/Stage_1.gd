extends Node2D

var score_value = 0
onready var score = get_node("Player/CanvasLayer/ui/scoreboard")
onready var enemy = get_tree().get_nodes_in_group("Enemies")

func _ready():
	pass


func _process(delta):
	
	for i in range(0,6):
		if enemy[i].life <= 0:
			score_value += enemy[i].score
	
	score._score_update(score_value)
	score_value = 0
	#if enemy.get("life") <= 0:
	#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://ui/credits.tscn")
