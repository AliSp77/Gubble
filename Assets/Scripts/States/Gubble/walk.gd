extends RigidState
#class_name RigidWalk

const WALK_ACCEL = 500.0
const WALK_DEACCEL = 400.0
const WALK_MAX_VELOCITY = 250.0
const MAX_FLOOR_AIRBORNE_TIME = 0.15

func enter():
	parent.animations.play(animation_name)

func process_physics(delta: float) -> RigidState:
	### Change to idle based on character horizontal velocity
	if abs(parent.linear_velocity.x) <= 1:
		ChangeState.emit(States["idle"])
		return null
		
	### Change to jump based on jump press
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		return null
	
	### Change to fall if character is not on the ground
	if not on_floor(delta):
		ChangeState.emit(States["fall"])
		return null
	
	### moving between platforms based on down pressed
	if Input.is_action_pressed("down") and !parent.stunned:
		ChangeState.emit(States["transition"])
		return null
	
	return null

### character forces 
func update_force(s: PhysicsDirectBodyState2D):
	### Character current move speed
	var lv = s.get_linear_velocity()
	### Physics engine step
	var step = s.get_step()
	### Getting character direction
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	### increase speed in the direction of movement
	if direction:
		if abs(lv.x) < WALK_MAX_VELOCITY:
			lv.x += WALK_ACCEL * step * direction
			#print(lv.x, ", acceleration")
		else:
			lv.x = WALK_MAX_VELOCITY * direction
	### always reducing speed because of friction
	else:
		var xv = abs(lv.x)
		xv -= WALK_DEACCEL * step
		if xv < 0:
			xv = 0
		lv.x = sign(lv.x) * xv
	### Applying move speed changes
	s.set_linear_velocity(lv)

### finding character placement
func on_floor(delta):
	if floor_finder(ground_detector_state):
		parent.airborne_time = 0.0
	else:
		parent.airborne_time += delta # Time it spent in the air.

	var floor : bool = parent.airborne_time < MAX_FLOOR_AIRBORNE_TIME
	return floor
