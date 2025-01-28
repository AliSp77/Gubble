extends Node2D
class_name PlayerAnimator

@export var player_controller: PlayerController
@export var animation_player: AnimationPlayer 
@export var sprite: Sprite2D 

func _process(_delta: float) -> void:
	if player_controller.current_direction == 1:
		sprite.flip_h = false
	elif player_controller.current_direction == -1:
		sprite.flip_h = true
	
	if abs(player_controller.velocity.x) > 0.0:
		animation_player.play("walk")
	elif player_controller.velocity.y < 0.0:
		animation_player.play("jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")
	else:
		animation_player.play("idle")
