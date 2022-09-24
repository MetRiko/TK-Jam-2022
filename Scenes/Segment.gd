extends KinematicBody2D


var movetoPosition: Vector2
var rotationAngle: float = deg2rad(3)
var forward_vector = Vector2(0,1)
var the_object = self
var orientation_global = (the_object.to_global( forward_vector ) - the_object.global_position)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass
	
	
func update_rotation_by_input():
	if Input.is_action_pressed("ui_right"):
		self.rotate(rotationAngle)
	if Input.is_action_pressed("ui_left"):
		self.rotate(-rotationAngle)
