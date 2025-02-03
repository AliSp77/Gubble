extends RigidState
class_name RigidIdle

@export
var walk: RigidState
@export
var jump: RigidState

func enter():
	parent.linear_velocity.x = 0
	
func process_physics(delta: float) -> RigidState:
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction != 0:
		ChangeState.emit(walk)
	
	if Input.is_action_just_pressed("jump") and not check_airborne():
		ChangeState.emit(jump)
		pass
	
	return null


func check_airborne() -> bool:
	var bodies = parent.get_colliding_bodies()

	if	!len(bodies) && !bodies.any(func(body): return body.get_class() == "TileMapLayer"):
		return true
	else:
		return false
