extends RigidState
#class_name RigidIdle
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"

func enter():
	parent.linear_velocity.x = 0
	
func process_physics(delta: float) -> RigidState:
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction != 0:
		ChangeState.emit(States["walk"])

	#if Input.is_action_just_pressed("jump") and ground_detection.get_collision_count():
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		pass
	
	return null
