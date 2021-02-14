extends CanvasLayer

func _gameover(evento):
	if evento == true:
		get_tree().paused = not get_tree().paused
		$gameover.visible = not $gameover.visible
		#$Pause_Screen.visible = not $Pause_Screen.visible
		print("gameover")


func _on_reset_pressed():
	get_tree().paused = not get_tree().paused
	#$gameover.visible = not $gameover.visible
	get_tree().reload_current_scene()
	print("reset")


func _on_exit_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene("res://TitleScr/TitleScreen.tscn")


func _on_credits_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene("res://ui/credits.tscn")
	
