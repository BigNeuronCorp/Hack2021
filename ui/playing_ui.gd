extends Node2D

func _on_right_touch_button_pressed():
	Input.action_press("ui_right")
func _on_left_touch_button_pressed():
	Input.action_press("ui_left")
func _on_left_touch_button_released():
	Input.action_release("ui_left")
func _on_right_touch_button_released():
	Input.action_release("ui_right")
