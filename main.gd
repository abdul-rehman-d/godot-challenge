extends Node2D


func _on_power_up_collected() -> void:
	for danger in get_tree().get_nodes_in_group("DangerObject"):
		if danger is DangerObject:
			danger.is_moving = false
	$Timers/PowerUpTimer.start()


func _on_power_up_timer_timeout() -> void:
	for danger in get_tree().get_nodes_in_group("DangerObject"):
		if danger is DangerObject:
			danger.is_moving = true
