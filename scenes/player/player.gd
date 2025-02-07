extends CharacterBody2D


@export var speed = 100.0
@export var jump_velocity = 400.0
@export var short_jump_velocity = 50.0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity
	if Input.is_action_just_released("jump"):
		if velocity.y < -short_jump_velocity:
			velocity.y = -short_jump_velocity

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if velocity.y:
		animated_sprite_2d.play("jump")
	elif velocity.x:
		if velocity.x > 0 and not animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = true
		elif velocity.x < 0 and animated_sprite_2d.flip_h:
			animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()
