extends RigidState

#var go_through: Timer
#var slam_force: Vector2 = Vector2(0,25)
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"
#var timeout: bool = false

#func _ready():
	#go_through = Timer.new()
	#go_through.wait_time = 0.1
	#go_through.one_shot = true
	#add_child(go_through)
	#go_through.timeout.connect(on_timeout)
	
#func on_timeout():
	#parent.set_collision_mask_value(4,true)
	#timeout = true

#func enter():
	#parent.set_collision_mask_value(4,false)
	#go_through.start()
	#timeout = false

func process_physics(_delta):

	if Input.is_action_just_pressed("down"):
		ChangeState.emit(States["slam"])
			
		#if ground_detection.get_collision_count() or parent.linear_velocity.y <= 1:
	if parent.linear_velocity.y <= 0.2:
		ChangeState.emit(States["walk"])
	
