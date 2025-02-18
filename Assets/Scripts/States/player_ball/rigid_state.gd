class_name RigidState
extends Node

signal ChangeState(RigidState)

@export
var animation_name: String
@export
var move_speed: float = 300



var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Hold a reference to the parent so that it can be controlled by the state
var parent: RigidBody2D

static var States: Dictionary
var ground_detector_state: ShapeCast2D

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> RigidState:
	return null

func process_frame(delta: float) -> RigidState:
	return null

func process_physics(delta: float) -> RigidState:
	return null

func update_force(state: PhysicsDirectBodyState2D) -> void:
	return
#
#func find_floor(s: PhysicsDirectBodyState2D) -> bool:
	#var step = s.get_step()
	#var found_floor := false
	#var floor_index = -1
	#for x in range(s.get_contact_count()):
		#var ci = s.get_contact_local_normal(x)
		#print(x)
		#if ci.dot(Vector2(0, -1)) > 0.6:
			#found_floor = true
			#floor_index = x
	#return found_floor

func floor_finder(detector: ShapeCast2D) -> bool:
	var found_floor := false
	var floor_index = -1
	for x in range(detector.get_collision_count()):
		var ci = detector.get_collision_normal(x)
		
		if ci.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x
		print(ci.dot(Vector2(0, -1)), " test")
		
	return found_floor
