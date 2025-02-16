extends RigidState
#class_name RigidIdle
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"
@onready var pid: Node = $"../../PID"

func enter():
	parent.animations.play(animation_name)
	
func process_physics(delta: float) -> RigidState:
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction != 0:
		ChangeState.emit(States["walk"])
		return null

	#if Input.is_action_just_pressed("jump") and ground_detection.get_collision_count():
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		return null
	
	if parent.linear_velocity.y >= 10 and ground_detection.get_collision_count():
		ChangeState.emit(States["fall"])
		return null

	if Input.is_action_pressed("down") and !parent.stunned:
		ChangeState.emit(States["transition"])
		return null
	#print(pid.calculate_force(0.0, delta))
	#parent.apply_central_force(Vector2(pid.calculate_force(0.0, delta),0))
	if abs(parent.linear_velocity.x) < 10:
		parent.linear_velocity.x = 0
	return null
