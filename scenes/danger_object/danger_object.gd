extends StaticBody2D

@export var begin_position: Marker2D
@export var end_position: Marker2D

@export var speed = 50.0

var target: Vector2 = Vector2.ZERO
var reverse: bool = false

func _ready() -> void:
	global_position = begin_position.global_position
	target = end_position.global_position
	reverse = false


func _process(delta: float) -> void:
	if global_position.distance_to(target) < 1:
		# reached
		if reverse:
			target = end_position.global_position
			reverse = false
		else:
			target = begin_position.global_position
			reverse = true
	
	global_position = global_position.move_toward(target, speed * delta)


func _on_hitbox_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("reload_current_scene")
