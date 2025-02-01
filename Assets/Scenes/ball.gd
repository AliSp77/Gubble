extends CharacterBody2D

@export var acceleration := 400.0
@export var max_speed := 200.0
@export var deceleration := 300.0
@export var jump_velocity := -300.0
@export var bounce_intensity := -100.0  # Small bounce effect

var velocity_x := 0.0
var jumping := false  # Track if the character was previously in air
var bouncing := false

func _physics_process(delta):
	print(jumping)
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if direction != 0:
		# Apply acceleration
		velocity_x += direction * acceleration * delta
	else:
		# Apply deceleration
		if abs(velocity_x) > 0:
			var decel_amount = deceleration * delta
			velocity_x -= sign(velocity_x) * min(abs(velocity_x), decel_amount)

	# Clamp velocity to max speed
	velocity_x = clamp(velocity_x, -max_speed, max_speed)

	# Jump logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jumping = true  # Track that we are now in the air
	
	if jumping and velocity.y == 0:
		jumping = false
		bouncing = true

# Detect landing (was falling, now on the floor)
	if bouncing and is_on_floor():
		velocity.y = bounce_intensity  # Apply small bounce
		bouncing = false  # Reset tracking
	
	# Apply velocity and move
	velocity.x = velocity_x
	move_and_slide()
