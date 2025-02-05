extends RigidState
class_name RigidWalk

@export_category("Movement Setup")
@export_group("Forces And Torques")
@export var move_force = Vector2(250, 0)
@export var move_torque = 150
 
func enter():
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	parent.apply_torque_impulse(move_torque * direction)

func process_physics(delta: float) -> RigidState:
	if abs(parent.linear_velocity.x) <= 1:
		ChangeState.emit(States["idle"])
		
	if Input.is_action_just_pressed("jump") and not check_airborne():
		ChangeState.emit(States["jump"])
		pass
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	parent.apply_central_force(move_force * direction)

	return null


func check_airborne() -> bool:
	var bodies = parent.get_colliding_bodies()

	if	!len(bodies) && !bodies.any(func(body): return body.get_class() == "TileMapLayer"):
		return true
	else:
		return false
