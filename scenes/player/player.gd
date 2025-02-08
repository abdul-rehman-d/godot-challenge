class_name Player
extends CharacterBody2D


@export var speed = 100.0
@export var jump_velocity = 380.0
@export var short_jump_velocity = 50.0


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var gpu_particles: GPUParticles2D = $RunningParticles
@onready var jump_audio: AudioStreamPlayer2D = $JumpAudio


func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_jump()
	handle_x_movement()
	handle_animations()
	handle_run_particles()

	move_and_slide()


func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity
		jump_audio.play()
	if Input.is_action_just_released("jump"):
		if velocity.y < -short_jump_velocity:
			velocity.y = -short_jump_velocity


func handle_x_movement() -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


func handle_animations() -> void:
	if velocity.y:
		animated_sprite.play("jump")
	elif velocity.x:
		if velocity.x > 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true
			animated_sprite.position.x = 3
			gpu_particles.position.x = -5
		elif velocity.x < 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
			animated_sprite.position.x = -3
			gpu_particles.position.x = 5
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")


func handle_run_particles() -> void:
	if gpu_particles.emitting and (not velocity.x or not is_on_floor()):
		gpu_particles.emitting = false
	elif not gpu_particles.emitting and velocity.x and is_on_floor():
		gpu_particles.emitting = true
