extends RigidState

var go_through: Timer
var timeout: bool = false

func _ready():
	go_through = Timer.new()
	go_through.wait_time = 0.2
	go_through.one_shot = true
	add_child(go_through)
	go_through.timeout.connect(on_timeout)
	
	
func on_timeout():
	parent.set_collision_mask_value(4,true)
	timeout = true
	ChangeState.emit(States["fall"])
	
func enter():
	parent.set_collision_mask_value(4,false)
	go_through.start()
	timeout = false
	
