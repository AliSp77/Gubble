extends State

@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		ChangeState.emit(jump_state)
		return jump_state
	if Input.is_action_just_pressed('left') or Input.is_action_just_pressed('right'):
		ChangeState.emit(move_state)
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		ChangeState.emit(fall_state)
	return null
