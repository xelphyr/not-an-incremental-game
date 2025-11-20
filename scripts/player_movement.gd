extends CharacterBody2D


const SPEED = 150.0
const SPRINT_SPEED = 300.0

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("front", "back")).normalized()

	if direction:
		if Input.is_action_pressed("sprint"):
			velocity = direction * SPRINT_SPEED
		else:
			velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()
