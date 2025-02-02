extends RigidBody2D

@onready var move_force = Vector2(2500, 0)
@onready var move_torque = 1500
@onready var max_move_speed = 100
@onready var jump_force = Vector2(0, -50000)
@onready var move: bool 
@onready var jump: bool
@onready var ground: RayCast2D = $ground

var airborne : bool

func _ready():
	pass
	
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#print(state.get_contact_collider(1))
func _process(delta: float) -> void:
	var apply_force = move_torque if self.linear_velocity.x == 0 else move_force
	
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if direction != 0 and check_move():
		movement(direction)
	
	if Input.is_action_just_pressed("jump") and check_jump():
		self.apply_central_force(jump_force)	
		
	#if Input.is_action_pressed("right") and check_move():
		#self.apply_impulse(move_right_force, Vector2(0,0))
	#if Input.is_action_just_pressed("left") and check_move():
		#self.apply_impulse(move_left_force, Vector2(0,0))

func check_one_the_ground() -> bool:
	return self.get_colliding_bodies().any(func(body): return body.get_class() == "TileMapLayer")

func check_airborne() -> bool:
	var bodies = self.get_colliding_bodies()

	airborne = true

	if	len(bodies) == 0 or bodies.any(func(body): return body.get_class() == "TileMapLayer"):
		airborne = false

	return airborne

func check_move() -> bool:
	var on_the_ground = self.check_one_the_ground()

	move = false

	if on_the_ground && abs(self.linear_velocity.x) < max_move_speed:
		move = true

	return move

func check_jump() -> bool:
	jump = false

	if self.check_one_the_ground():
		jump = true

		
	return jump

func movement(direction: float):
	if abs(self.linear_velocity.x) <=  1:
		self.apply_torque_impulse(direction * move_torque)
	else:
		self.apply_force(direction * move_force)
