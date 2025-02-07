@tool
class_name Collectable
extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $Area2D/AnimatedSprite2D

@export var sprite_frames: SpriteFrames = null:
	set(value):
		sprite_frames = value
		if animated_sprite:
			animated_sprite.sprite_frames = value
		if Engine.is_editor_hint():
			update_configuration_warnings()

@export var fade_out_time: float = 1.0

signal collected

var is_active = true


func _get_configuration_warnings() -> PackedStringArray:
	if sprite_frames == null:
		return ["Sprite Frames is not set."]
	return [];


func _ready() -> void:
	if animated_sprite and sprite_frames:
		animated_sprite.sprite_frames = sprite_frames
		var all_animations = sprite_frames.get_animation_names()
		if all_animations.size() > 0:
			animated_sprite.play(all_animations[0])


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("hello")
	if not is_active: return
	
	is_active = false
	collected.emit()
	
	var tween = create_tween()
	tween.tween_method(_set_modulate, 1.0, 0.0, fade_out_time)
	await tween.finished
	
	queue_free()


func _set_modulate(value: float) -> void:
	animated_sprite.modulate = Color(1.0, 1.0, 1.0, value)
