extends Node2D


func _on_right_touch_button_pressed():
	Input.action_press("right")
func _on_left_touch_button_pressed():
	Input.action_press("left")
func _on_left_touch_button_released():
	Input.action_release("left")
func _on_right_touch_button_released():
	Input.action_release("right")
