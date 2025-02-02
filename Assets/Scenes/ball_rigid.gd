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


func _ready():
	pass
	
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#print(state.get_contact_collider(1))
func _process(delta: float) -> void:
	check_airborne()
	
	var apply_force = move_torque if self.linear_velocity.x == 0 else move_force
	movement(Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	if Input.is_action_just_pressed("jump") and !airborne:
		self.apply_central_force(jump_force)	

func check_airborne() -> void:
	var bodies = self.get_colliding_bodies()

	if	!len(bodies) && !bodies.any(func(body): return body.get_class() == "TileMapLayer"):
		if !airborne:
			should_apply_airborne_force = true
		airborne = true
	else:
		airborne = false

func movement(direction: float):
	if !direction or abs(self.linear_velocity.x) >= max_move_speed:
		return;

	if airborne:
		if should_apply_airborne_force:
			should_apply_airborne_force = false
			self.apply_force(direction * airborne_force)
	elif abs(self.linear_velocity.x) <=  1:
		self.apply_torque_impulse(direction * move_torque)
	else:
		self.apply_force(direction * move_force)
