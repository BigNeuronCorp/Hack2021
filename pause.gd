extends CanvasLayer


func _pause(evento):
	if evento == true:
		get_tree().paused = not get_tree().paused
		$Pause_Screen.visible = not $Pause_Screen.visible


func _on_TouchScreenButton_pressed():
	get_tree().paused = not get_tree().paused
	$Pause_Screen.visible = not $Pause_Screen.visible
	


func _on_TouchScreenButton2_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene("res://TitleScr/TitleScreen.tscn")
