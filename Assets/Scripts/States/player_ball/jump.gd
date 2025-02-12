extends RigidState
#class_name RigidJump

@export var airborne_force = Vector2(100,0)
@export var jump_force = Vector2(0, -380)
@onready var ground_detection: ShapeCast2D = $"../../GroundDetection"

func enter():
	parent.apply_central_impulse(jump_force)
	parent.animations.play(animation_name)
	
func process_physics(delta: float):
	if parent.linear_velocity.y >= 2:
		ChangeState.emit(States["fall"])
	
	if Input.is_action_just_pressed("down"):
		ChangeState.emit(States["slam"])
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	parent.apply_central_force(airborne_force * direction)

	pass
