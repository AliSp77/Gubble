extends RigidState
#class_name RigidJump

@export var airborne_force = Vector2(100,0)
@export var jump_force = Vector2(0, -430)
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"
var timer: Timer
var timeout: bool

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.08
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	pass

func enter():
	parent.apply_central_impulse(jump_force)
	timeout = false
	timer.start()
	parent.animations.play(animation_name)
	
func process_physics(delta: float):
	#if not check_airborne() and abs(parent.linear_velocity.x) <= 1:
		#ChangeState.emit(idle)
	if ground_detection.get_collision_count() and timeout:
		ChangeState.emit(States["walk"])
	
	if parent.linear_velocity.y >= 2:
		ChangeState.emit(States["fall"])
	
	if Input.is_action_just_pressed("down") and !ground_detection.get_collision_count():
		ChangeState.emit(States["slam"])
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	parent.apply_central_force(airborne_force * direction)

	pass

func _on_timeout():
	timeout = true

func exit():
	parent.linear_velocity.y = 0
