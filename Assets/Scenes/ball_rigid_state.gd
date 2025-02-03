extends RigidBody2D

@onready var move: bool 
@onready var jump: bool
@onready var should_apply_airborne_force: bool = true;
@onready var airborne : bool

@export_category("Movement Setup")
@export_group("Forces And Torques")
@onready var move_force = Vector2(2500, 0)
@onready var move_torque = 1500
@onready var airborne_force = Vector2(10000,0)
@onready var jump_force = Vector2(0, -30000)

@export_group("Speed")
@onready var max_move_speed = 300
@onready var state_machine: StateMachine = $StateMachine


func _ready():
	state_machine.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

	
