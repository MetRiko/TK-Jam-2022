extends KinematicBody2D


var direction: Vector2 = Vector2.RIGHT
var velocity: int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	update_direction_by_input()
	var velocity_vec: Vector2 = get_linear_velocity()
	velocity_vec = move_and_slide(velocity_vec, Vector2.UP)


func update_direction_by_input():
	if Input.is_action_pressed("ui_right"):
		direction = direction.rotated(deg2rad(3))
	if Input.is_action_pressed("ui_left"):
		direction = direction.rotated(deg2rad(-3))

func get_linear_velocity():
	var linear_velocity: Vector2
	linear_velocity.x = direction.x * velocity
	linear_velocity.y = direction.y * velocity
	return linear_velocity
