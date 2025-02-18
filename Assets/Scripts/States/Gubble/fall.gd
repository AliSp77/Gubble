extends RigidState

const MAX_FLOOR_AIRBORNE_TIME = 0.15

func enter():
	parent.gravity_scale = 1.2

func process_physics(_delta):

	if Input.is_action_just_pressed("down"):
		ChangeState.emit(States["slam"])
	
	if on_floor(_delta):
		ChangeState.emit(States["walk"])
	
func exit():
	parent.gravity_scale = 1

func on_floor(delta):
	if floor_finder(ground_detector_state):
		parent.airborne_time = 0.0
	else:
		parent.airborne_time += delta # Time it spent in the air.

	var floor : bool = parent.airborne_time < MAX_FLOOR_AIRBORNE_TIME
	return floor
