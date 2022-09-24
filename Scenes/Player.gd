extends KinematicBody2D

var direction: Vector2 = Vector2.DOWN
var velocity: int = 30
var rotationAngle: float = deg2rad(4)
var forward_vector = Vector2(0,1)
var the_object = self

var alive := true

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionDetector.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	return
	if alive and body != self:
		alive = false
		print("Game over!")

func _movement_update(delta):
	if alive:
		var velocity_vec: Vector2 = get_linear_velocity()
		velocity_vec = move_and_slide(velocity_vec, Vector2.UP)

func _rotation_update(delta : float):
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

func defeat():
	print("you lose")
	pass


func _on_CollisionDetector_area_entered(area):
	if area.collision.name.match("Walls") or area.collision.name.match("*TetrisBlock*"):
		defeat()
