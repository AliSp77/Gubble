extends RigidState
class_name RigidJump

@export var airborne_force = Vector2(100,0)
@export var jump_force = Vector2(0, -20000)

func enter():
	parent.apply_central_force(jump_force)
	
func process_physics(delta: float):
	#if not check_airborne() and abs(parent.linear_velocity.x) <= 1:
		#ChangeState.emit(idle)
	
	if check_airborne():
		ChangeState.emit(States["walk"])
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	parent.apply_central_impulse(airborne_force * direction)
	print("applying air force")
	pass
	
func check_airborne() -> bool:
	var bodies = parent.get_colliding_bodies()

	#if	!len(bodies) && !bodies.any(func(body): return body.get_class() == "TileMapLayer"):
	if	!bodies.any(func(body): return body.get_class() == "TileMapLayer"):
		return true
	else:
		return false
