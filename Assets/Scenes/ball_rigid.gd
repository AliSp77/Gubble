extends RigidBody2D

@onready var move_right_force = Vector2(1500, 0)
@onready var move_left_force = Vector2(-1500, 0)
@onready var max_move_speed = 150
@onready var jump_force = Vector2(0, -18000)
@onready var move: bool 
@onready var jump: bool
@onready var ground: RayCast2D = $ground

func _ready():
	pass
	
func _process(delta: float) -> void:
	print()
	if Input.is_action_just_pressed("right") and check_move():
		self.apply_impulse(move_right_force, Vector2(0,0))
	if Input.is_action_just_pressed("left") and check_move():
		self.apply_impulse(move_left_force, Vector2(0,0))

func check_move() -> bool:
	if abs(self.linear_velocity.x) < max_move_speed and ground.is_colliding():
		move = true
	else:
		move = false
		
	return move

func check_jump() -> bool:
	if ground.is_colliding():
		jump = true
	else:
		jump = false
		
	return jump


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
