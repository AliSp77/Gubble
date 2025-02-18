extends RigidState
#class_name RigidIdle
#@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"
#@onready var pid: Node = $"../../PID"
const WALK_DEACCEL = 500.0

func enter():
	parent.animations.play(animation_name)
	
func process_physics(delta: float) -> RigidState:
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction != 0:
		ChangeState.emit(States["walk"])
		return null

	#if Input.is_action_just_pressed("jump") and ground_detection.get_collision_count():
	if Input.is_action_just_pressed("jump"):
		ChangeState.emit(States["jump"])
		return null

	if parent.linear_velocity.y >= 10 and not floor_finder(ground_detector_state):
		ChangeState.emit(States["fall"])
		return null

	if Input.is_action_pressed("down") and !parent.stunned:
		ChangeState.emit(States["transition"])
		return null
			
	return null

func update_force(s: PhysicsDirectBodyState2D):
	var lv := s.get_linear_velocity()
	var step := s.get_step()
	if abs(lv.x) < 1:
		lv.x = 0
	
	var xv = abs(lv.x)
	xv -= WALK_DEACCEL * step
	if xv < 0:
		xv = 0
	lv.x = sign(lv.x) * xv
	
	#lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv) 
	
