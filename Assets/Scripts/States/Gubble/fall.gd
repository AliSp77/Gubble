extends RigidState

const MAX_FLOOR_AIRBORNE_TIME = 0.15

func enter():
	parent.gravity_scale = 1.2

func process_physics(_delta):

	if Input.is_action_just_pressed("down"):
		ChangeState.emit(States["slam"])
		return null

	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["want_jump"])
		return null
	
	if floor_finder(ground_detector_state) and abs(parent.linear_velocity.y) > 0.5:
		ChangeState.emit(States["walk"])
		return null
	
	if floor_finder(ground_detector_state) and abs(parent.linear_velocity.y) < 0.5:
		ChangeState.emit(States["idle"])
		return null
		
func exit():
	parent.gravity_scale = 1
