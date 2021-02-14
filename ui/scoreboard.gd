extends Node2D

func _score_update(score):
	$score_b/Control/score.set_text(str(score))
