extends Node2D

func _on_right_pressed():
	Input.is_action_just_pressed("ui_right")
func _on_right_released():
	Input.action_just_release("ui_right")


func _on_left_pressed():
	Input.action_just_press("ui_left")
func _on_left_released():
	Input.action_just_release("ui_left")


func _on_jump_just_pressed():
	Input.action_press("ui_select")
func _on_jump_just_released():
	Input.action_release("ui_select")


func _on_shoot_just_pressed():
	Input.action_press("ui_focus_next")
func _on_shoot_just_released():
	Input.action_release("ui_focus_next")


func _on_pause_just_pressed():
	Input.action_press("ui_cancel")
func _on_pause_just_released():
	Input.action_release("ui_cancel")
