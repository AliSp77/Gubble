extends RigidState
#class_name RigidWalk

@export_category("Movement Setup")
@export_group("Forces And Torques")
@export var move_force = Vector2(450, 0)
@export var move_torque = 250
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"

func enter():
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	parent.apply_torque_impulse(move_torque * direction)
	parent.animations.play(animation_name)

func process_physics(delta: float) -> RigidState:
	if abs(parent.linear_velocity.x) <= 10:
		ChangeState.emit(States["idle"])
		return null
		
	#if Input.is_action_just_pressed("jump") and ground_detection.get_collision_count():
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		return null

	if parent.linear_velocity.y >= 10:
		ChangeState.emit(States["fall"])
		return null
	
	if Input.is_action_pressed("down") and !parent.stunned:
		ChangeState.emit(States["transition"])
		return null
	
	if parent.linear_velocity.y < 200: 
		var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
		parent.apply_central_force(move_force * direction)
	return null

#func process_input(event):
	#if event.is_action_pressed("down"):
		#parent.set_collision_mask_value(4, false)
	#else:
		#parent.set_collision_mask_value(4, true)
