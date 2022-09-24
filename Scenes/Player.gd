extends KinematicBody2D


var direction: Vector2 = Vector2.UP
var velocity: int = 100
var rotationAngle: float = deg2rad(3)
var forward_vector = Vector2(0,1)
var the_object = self
var orientation_global = (the_object.to_global( forward_vector ) - the_object.global_position)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	update_direction_by_input(delta)
	var velocity_vec: Vector2 = get_linear_velocity()
	velocity_vec = move_and_slide(velocity_vec, Vector2.UP)

func update_direction_by_input(delta : float):
	if Input.is_action_pressed("ui_right"):
		var angle = rotationAngle * delta * 60.0
		direction = direction.rotated(angle)
		rotate(angle)
	if Input.is_action_pressed("ui_left"):
		var angle = -rotationAngle * delta * 60.0
		direction = direction.rotated(angle)
		rotate(angle)


func get_linear_velocity():
	var linear_velocity: Vector2
	linear_velocity.x = direction.x * velocity
	linear_velocity.y = direction.y * velocity
	return linear_velocity
