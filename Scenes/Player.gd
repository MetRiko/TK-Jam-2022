extends KinematicBody2D


var direction: Vector2 = Vector2.UP
var velocity: int = 100
var rotationAngle: float = deg2rad(3)
var forward_vector = Vector2(0,1)
var the_object = self
var orientation_global = (the_object.to_global( forward_vector ) - the_object.global_position)

signal rotate(vec)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	update_direction_by_input()
	var velocity_vec: Vector2 = get_linear_velocity()
	velocity_vec = move_and_slide(velocity_vec, Vector2.UP)

func update_direction_by_input():
	if Input.is_action_pressed("ui_right"):
		direction = direction.rotated(rotationAngle)
		self.rotate(rotationAngle)
	if Input.is_action_pressed("ui_left"):
		direction = direction.rotated(-rotationAngle)
		self.rotate(-rotationAngle)


func get_linear_velocity():
	var linear_velocity: Vector2
	linear_velocity.x = direction.x * velocity
	linear_velocity.y = direction.y * velocity
	return linear_velocity
