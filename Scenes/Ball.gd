extends KinematicBody2D

var velocity = 200.0
var dirVec = Vector2.ZERO

func castBall():
	dirVec = Vector2(rand_range(-0.5,0.5),1)

func _physics_process(delta):
	move_and_collide(dirVec*velocity)

func _ready():
	castBall()

