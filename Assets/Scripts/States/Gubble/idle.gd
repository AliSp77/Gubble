extends RigidState
#class_name RigidIdle

const IDLE_DEACCEL = 200.0
const MAX_FLOOR_AIRBORNE_TIME = 0.15

func enter():
	parent.animations.play(animation_name)
	
func process_physics(delta: float) -> RigidState:
	###finding player moving direction
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	###Change state to walk if direction is not zero
	if direction != 0:
		ChangeState.emit(States["walk"])
		return null

	### Change state to jump if jump button pressed
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		return null

	###	If player is not on the ground then change state to fall
	if not on_floor(delta):
		ChangeState.emit(States["fall"])
		return null
	
	### Moving down the roads
	if Input.is_action_pressed("down") and !parent.stunned:
		ChangeState.emit(States["transition"])
		return null
			
	return null

### slowing down character movements using a deceleration value
func update_force(s: PhysicsDirectBodyState2D):
	var lv := s.get_linear_velocity()
	var step := s.get_step()
	if abs(lv.x) < 1:
		lv.x = 0
	
	var xv = abs(lv.x)
	xv -= IDLE_DEACCEL * step
	if xv < 0:
		xv = 0
	lv.x = sign(lv.x) * xv
	
	#lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv) 

### finding character placement
func on_floor(delta):
	if floor_finder(ground_detector_state):
		parent.airborne_time = 0.0
	else:
		parent.airborne_time += delta # Time it spent in the air.

	var floor : bool = parent.airborne_time < MAX_FLOOR_AIRBORNE_TIME
	return floor
