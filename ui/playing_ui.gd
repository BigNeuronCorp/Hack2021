extends Node2D

func _on_right_pressed():
	Input.action_press("ui_right")
func _on_right_released():
	Input.action_release("ui_right")


func _on_left_pressed():
	Input.action_press("ui_left")
func _on_left_released():
	Input.action_release("ui_left")


func _on_jump_pressed():
	Input.action_press("ui_select")
func _on_jump_released():
	Input.action_release("ui_select")


func _on_shoot_pressed():
	Input.action_press("ui_focus_next")
func _on_shoot_released():
	Input.action_release("ui_focus_next")

func _on_pause_pressed():
	Input.action_press("ui_cancel")
func _on_pause_released():
	Input.action_release("ui_cancel")
