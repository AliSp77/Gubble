extends State
class_name FallState

@export
var idle_state: State
@export
var move_state: State

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var movement = Input.get_axis('left', 'right') * move_speed
	
	if movement != 0:
		parent.sprite.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			ChangeState.emit(move_state)
		ChangeState.emit(idle_state)
	return null
