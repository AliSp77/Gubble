extends RigidState
#class_name RigidWalk

@export_category("Movement Setup")
@export_group("Forces And Torques")
@export var move_force = Vector2(250, 0)
@export var move_torque = 150
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"

func enter():
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	parent.apply_torque_impulse(move_torque * direction)

func process_physics(delta: float) -> RigidState:
	if abs(parent.linear_velocity.x) <= 1:
		ChangeState.emit(States["idle"])
		
	#if Input.is_action_just_pressed("jump") and ground_detection.get_collision_count():
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		pass
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	parent.apply_central_force(move_force * direction)

	return null
