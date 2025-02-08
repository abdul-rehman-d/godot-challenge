@tool
class_name Level
extends Node

signal power_up_collected
signal victory_flag_collected
signal died

@export var victory_flag: Collectable:
	set(value):
		victory_flag = value
		if Engine.is_editor_hint():
			update_configuration_warnings()
		victory_flag.collected.connect(_on_victory_flag_collected)


@export var power_ups: Array[Collectable]:
	set(value):
		power_ups = value
		for power_up in power_ups:
			power_up.collected.connect(_on_power_up_collected)


func _get_configuration_warnings() -> PackedStringArray:
	if victory_flag == null:
		return ["Victory Flag is not set."]
	return [];


func _on_victory_flag_collected() -> void:
	victory_flag_collected.emit()


func _on_power_up_collected() -> void:
	power_up_collected.emit()
