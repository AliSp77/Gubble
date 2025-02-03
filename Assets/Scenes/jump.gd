extends RigidState
class_name RigidJump

@export
var idle: RigidState
@export
var walk: RigidState

@onready var airborne_force = Vector2(100,0)
@onready var jump_force = Vector2(0, -80000)

func enter():
	parent.apply_central_force(jump_force)
	
func process_physics(delta: float):
	print(check_airborne())
	if not check_airborne() and abs(parent.linear_velocity.x) <= 1:
		ChangeState.emit(idle)
	
	if not check_airborne():
		ChangeState.emit(walk)
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	parent.apply_central_force(airborne_force * direction)
	print("applying air force")
	pass
	
func check_airborne() -> bool:
	var bodies = parent.get_colliding_bodies()

	if	!len(bodies) == 0 && !bodies.any(func(body): return body.get_class() == "TileMapLayer"):
		return true
	else:
		return false
