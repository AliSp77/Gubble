extends RigidState
#class_name RigidJump

const AIR_ACCEL = 250.0
const AIR_DEACCEL = 250.0
const AIR_MAX_VELOCITY = 250
@export var jump_force = Vector2(0, -380)

func enter():
	parent.apply_central_impulse(jump_force)
	parent.animations.play(animation_name)
	
func process_physics(delta: float):	
	### Slaming down if button pressed
	if Input.is_action_just_pressed("down"):
		ChangeState.emit(States["slam"])
	pass

func update_force(s: PhysicsDirectBodyState2D):
	var lv := s.get_linear_velocity()
	var step := s.get_step()
	### change state to fall after vertical speed change 
	if lv.y > 0:
		ChangeState.emit(States["fall"])
	### Getting character direction
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	### increase speed in the direction of movement
	if direction:
		if abs(lv.x) < AIR_MAX_VELOCITY:
			lv.x += AIR_ACCEL * step * direction
			#print(lv.x, ", acceleration")
		else:
			lv.x = AIR_MAX_VELOCITY * direction
	### always reducing speed because of friction
	else:
		var xv = abs(lv.x)
		xv -= AIR_DEACCEL * step
		if xv < 0:
			xv = 0
		lv.x = sign(lv.x) * xv
	### Applying move speed changes
	s.set_linear_velocity(lv)
