extends Node2D

@onready var level_container: Node2D = $Level
@onready var power_up_audio: AudioStreamPlayer2D = $Audio/PowerUpAudio
@onready var victory_audio: AudioStreamPlayer2D = $Audio/VictoryAudio

func _ready() -> void:
	load_level(0)


func load_level(level: int) -> void:
	var level_scene: PackedScene = load("res://scenes/levels/level_" + str(level) + ".tscn")
	var level_instance: Level = level_scene.instantiate()
	level_instance.died.connect(_died)
	level_instance.power_up_collected.connect(_on_power_up_collected)
	level_instance.victory_flag_collected.connect(_on_victory_flag_collected)
	for child in level_container.get_children():
		child.queue_free()
	level_container.add_child(level_instance)


func _on_power_up_collected() -> void:
	power_up_audio.play()
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
	victory_audio.play()
	Engine.time_scale = 0.0
	$CanvasLayer/VictoryScreen.show()


func _died() -> void:
	get_tree().reload_current_scene()
