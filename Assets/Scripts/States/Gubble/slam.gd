extends RigidState

var slam_force := Vector2(0,400)
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"
var stun_timer: Timer

func _ready():
	stun_timer = Timer.new()
	stun_timer.wait_time = 0.35
	stun_timer.one_shot = true
	add_child(stun_timer)
	stun_timer.timeout.connect(check_stun)

func enter():
	parent.apply_central_impulse(slam_force)
	parent.physics_material_override.absorbent = true
	parent.stunned = true
	stun_timer.start()
	print("slaaaaam")

func process_physics(_delta):

	if floor_finder(ground_detector_state) and abs(parent.linear_velocity.y) > 0.5:
		ChangeState.emit(States["walk"])
		return null
	
	if floor_finder(ground_detector_state) and abs(parent.linear_velocity.y) < 0.5:
		ChangeState.emit(States["idle"])
		return null

func exit():
	parent.physics_material_override.absorbent = false

func check_stun():
	parent.stunned = false
