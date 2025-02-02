extends RigidBody2D

@onready var move_right_force = Vector2(1500, 0)
@onready var move_left_force = Vector2(-1500, 0)
@onready var max_move_speed = 150
@onready var jump_force = Vector2(0, -860)
@onready var move: bool 
@onready var jump: bool
@onready var ground: RayCast2D = $ground

func _ready():
	pass
	
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#print(state.get_contact_collider(1))
	
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("jump") and check_jump():
		self.apply_impulse(jump_force, Vector2(0,0))	
		
	if Input.is_action_just_pressed("right") and check_move():
		self.apply_impulse(move_right_force, Vector2(0,0))
	if Input.is_action_just_pressed("left") and check_move():
		self.apply_impulse(move_left_force, Vector2(0,0))

func check_one_the_ground() -> bool:
	return self.get_colliding_bodies().any(func(body): return body.get_class() == "TileMapLayer")

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
