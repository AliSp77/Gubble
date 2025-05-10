extends RigidState

var timer: Timer
const MAX_FLOOR_AIRBORNE_TIME = 0.15

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.15
	add_child(timer)
	timer.timeout.connect(on_timeout)
	
func enter():
	timer.start()
	
func on_timeout():
	ChangeState.emit(States["fall"])
	
func process_physics(delta):
	if floor_finder(ground_detector_state):
		ChangeState.emit(States["jump"])
		return null
