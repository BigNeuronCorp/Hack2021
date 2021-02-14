extends Area2D


func _on_PowerUp_body_entered(body):
	if body.name == "Player":
		body.has_powerup("vaccine_2")
		queue_free()
