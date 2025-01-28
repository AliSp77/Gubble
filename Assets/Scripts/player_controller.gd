extends CharacterBody2D
class_name	PlayerController

@export_range(0.0, 15.0) var SPEED: float = 5
@export_range(0.0, 15.0) var JUMP_VELOCITY: float = 10.00

var speed_multiplier: int = 20
var deceleration_multiplier: int = 10
var jump_multiplier: int = -20
var current_direction: int = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * jump_multiplier

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if current_direction != direction:
		current_direction = direction
	if direction:
		velocity.x = current_direction * SPEED * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration_multiplier)

	move_and_slide()
