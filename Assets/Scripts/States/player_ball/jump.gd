extends RigidState
#class_name RigidJump

@export var airborne_force = Vector2(100,0)
@export var jump_force = Vector2(0, -400)
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"
var timer: Timer
var timeout: bool

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.1
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	pass

func enter():
	parent.apply_central_impulse(jump_force)
	timeout = false
	timer.start()
	
func process_physics(delta: float):
	#if not check_airborne() and abs(parent.linear_velocity.x) <= 1:
		#ChangeState.emit(idle)
	print(!ground_detection.get_collision_count())
	if ground_detection.get_collision_count() and timeout:
		ChangeState.emit(States["walk"])
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	parent.apply_central_force(airborne_force * direction)

	pass

func _on_timeout():
	timeout = true
