extends RigidState

func process_physics(_delta):

	if Input.is_action_just_pressed("down"):
		ChangeState.emit(States["slam"])
	
	
	if floor_finder(ground_detector_state):
	#if parent.linear_velocity.y <= 0.2:
		ChangeState.emit(States["walk"])
	
