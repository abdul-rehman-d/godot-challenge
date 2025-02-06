extends CharacterBody2D


@export var speed = 100.0
@export var jump_velocity = 400.0
@export var short_jump_velocity = 50.0


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

	move_and_slide()
