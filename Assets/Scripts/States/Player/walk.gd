extends State
class_name WalkState

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State

var deceleration_speed = 30

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		ChangeState.emit(jump_state)
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis('left', 'right') * move_speed 
	
	if movement == 0:
		ChangeState.emit(idle_state)
	
	parent.sprite.flip_h = movement < 0
	parent.velocity.x += movement - deceleration_speed
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		ChangeState.emit(fall_state)
	return null
