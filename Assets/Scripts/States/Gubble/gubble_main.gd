extends RigidBody2D
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine

var stunned: bool = false
var airborne_time: float = 1e20

func _ready():
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state_machine.update_force(state)

	
