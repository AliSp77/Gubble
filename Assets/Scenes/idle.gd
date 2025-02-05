extends RigidState
class_name RigidIdle

func enter():
	parent.linear_velocity.x = 0
	print(States)
	
func process_physics(delta: float) -> RigidState:
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction != 0:
		ChangeState.emit(States["walk"])
	
	if Input.is_action_just_pressed("jump") and not check_airborne():
		ChangeState.emit(States["jump"])
		pass
	
	return null


func check_airborne() -> bool:
	var bodies = parent.get_colliding_bodies()

	if	!len(bodies) && !bodies.any(func(body): return body.get_class() == "TileMapLayer"):
		return true
	else:
		return false
