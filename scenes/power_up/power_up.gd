extends Node2D

signal collected
@onready var animated_sprite: AnimatedSprite2D = $Area2D/AnimatedSprite2D

var is_active = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not is_active: return
	
	is_active = false
	collected.emit()
	
	var tween = create_tween()
	tween.tween_method(_set_modulate, 1.0, 0.0, 1.0)
	await tween.finished
	
	queue_free()


func _set_modulate(value: float) -> void:
	animated_sprite.modulate = Color(1.0, 1.0, 1.0, value)
