extends RigidState
#class_name RigidWalk

@export_category("Movement Setup")
@export_group("Forces And Torques")
@export var move_force = Vector2(450, 0)
@export var move_torque = 250
#@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"

const WALK_ACCEL = 500.0
const WALK_DEACCEL = 500.0
const WALK_MAX_VELOCITY = 250.0

func enter():
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	parent.apply_torque_impulse(move_torque * direction)
	parent.animations.play(animation_name)

func process_physics(delta: float) -> RigidState:
	if abs(parent.linear_velocity.x) <= 1:
		ChangeState.emit(States["idle"])
		return null
		
	#if Input.is_action_just_pressed("jump") and ground_detection.get_collision_count():
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		return null

	if parent.linear_velocity.y >= 10 and !floor_finder(ground_detector_state):
		ChangeState.emit(States["fall"])
		return null
	
	if Input.is_action_pressed("down") and !parent.stunned:
		ChangeState.emit(States["transition"])
		return null
	
	print(floor_finder(ground_detector_state), ", gound_detection")

	return null

func update_force(s: PhysicsDirectBodyState2D):
	var lv = s.get_linear_velocity()
	var step = s.get_step()
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction:
		if abs(lv.x) < WALK_MAX_VELOCITY:
			lv.x += WALK_ACCEL * step * direction
			#print(lv.x, ", acceleration")
		else:
			lv.x = WALK_MAX_VELOCITY * direction
	else:
		#print(lv.x, ", deceleration")
		var xv = abs(lv.x)
		xv -= WALK_DEACCEL * step
		if xv < 0:
			xv = 0
		lv.x = sign(lv.x) * xv
	
	#lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv)
