extends Area2D


func _on_body_entered(body: Node2D) -> void:
	# half the speed
	if body is Player:
		body.speed /= 2


func _on_body_exited(body: Node2D) -> void:
	# reset the speed
	if body is Player:
		body.speed *= 2
