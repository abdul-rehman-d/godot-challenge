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


func _on_restart_button_pressed() -> void:
	get_tree().call_deferred("reload_current_scene")
	Engine.time_scale = 1.0


func _on_victory_flag_collected() -> void:
	Engine.time_scale = 0.0
	$CanvasLayer/VictoryScreen.show()
