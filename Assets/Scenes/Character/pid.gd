extends Node

# PID coefficients
@export var kp: float = 10.0  # Proportional gain
@export var ki: float = 0.5   # Integral gain
@export var kd: float = 2.0   # Derivative gain

# PID variables
var prev_error: float = 0.0
var integral: float = 0.0

func calculate_force(target_position: float, delta: float):
	# Calculate the current error
	var error: float = target_position - get_parent().linear_velocity.x

	# Compute integral term (accumulated error)
	integral += error * delta

	# Compute derivative term (rate of change of error)
	var derivative: float = (error - prev_error) / delta

	# Compute PID force
	var force: float = (kp * error) + (ki * integral) + (kd * derivative)

	# Store previous error for next iteration
	prev_error = error
	
	return error
