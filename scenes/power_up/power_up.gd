extends Node2D

signal collected
@onready var animated_sprite: AnimatedSprite2D = $Area2D/AnimatedSprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	collected.emit()
	animated_sprite.play("hit")
	await animated_sprite.animation_finished
	queue_free()
	
