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
