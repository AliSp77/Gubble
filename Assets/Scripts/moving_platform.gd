extends Path2D
class_name MovingPlatform

func _ready() -> void:
	pass
	

func move_towards():
	var tween = get_tree().create_tween().set_loops()
