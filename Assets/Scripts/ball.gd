extends CharacterBody2D

@export_category("Main Category")

@export_group("My Properties")
@export var acceleration := 400.0
@export var max_speed := 200.0
@export var deceleration := 300.0
@export var jump_velocity := -300.0
@export var bounce_intensity := -100.0  # Small bounce effect

var velocity_x := 0.0
var jumping := false  # Track if the character was previously in air
var bouncing := false
const MASS := 1
const UP := Vector2.UP

func _physics_process(delta):
	var floor_normal := get_floor_normal()
	var floor_angle := floor_normal.angle_to(UP)
	
	#velocity.x = get_gravity().y * MASS * sin(floor_angle) 
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if direction != 0:
		# Apply acceleration
		velocity_x += direction * acceleration * delta
	else:
		# Apply slope speed
		if is_on_floor():
			velocity_x += -get_gravity().y * MASS * sin(floor_angle) * delta
		# Apply deceleration
		if abs(velocity_x) > 0:
			var decel_amount = deceleration * delta * cos(floor_angle)
			velocity_x -= sign(velocity_x) * min(abs(velocity_x), decel_amount) 

	# Clamp velocity to max speed
	velocity_x = clamp(velocity_x, -max_speed, max_speed)

	# Jump logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jumping = true  # Track that we are now in the air
	
	#if jumping and velocity.y == 0:
		#jumping = false
		#bouncing = true
#
## Detect landing (was falling, now on the floor)
	#if bouncing and is_on_floor():
		#velocity.y = bounce_intensity  # Apply small bounce
		#bouncing = false  # Reset tracking
	
	# Apply velocity and move
	print(velocity_x, " velocity x")
	velocity.x = velocity_x

	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#print("Collided with: ", collision.get_collider().name)
	#print(get_floor_angle(Vector2(0, -1)))
	move_and_slide()
