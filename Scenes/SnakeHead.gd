extends KinematicBody2D


var direction: Vector2 = Vector2.RIGHT
var velocity: Vector2 = Vector2(10.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	update_direction_by_input()
	var velocity_calc: Vector2 = get_linear_velocity()
	velocity = move_and_slide(velocity_calc, Vector2.UP)


func update_direction_by_input():
	if Input.is_action_pressed("ui_right"):
		direction.rotated(deg2rad(20))
		print(direction)
	if Input.is_action_pressed("ui_left"):
		direction.rotated(deg2rad(-20))
		print(direction)

func get_linear_velocity():
	var linear_velocity: Vector2
	linear_velocity.x = direction.x * velocity.x
	linear_velocity.y = direction.y * velocity.y
	return linear_velocity
