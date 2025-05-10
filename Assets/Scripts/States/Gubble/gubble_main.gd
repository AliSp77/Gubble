extends RigidBody2D
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var colider: CollisionShape2D = $Colider

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
	for collider_index in state.get_contact_count():
		var collider := state.get_contact_collider_object(collider_index)
		var collision_normal := state.get_contact_local_normal(collider_index)
		
		if collider is WorldBoundry and collision_normal == Vector2(0,-1):
			self.respawn()
			return 

func respawn():
	self.position = Vector2(20,20)
