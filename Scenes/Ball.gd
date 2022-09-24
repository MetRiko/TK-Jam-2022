extends KinematicBody2D

var velocity = 2.0
var dirVec = Vector2.ZERO

func castBall():
	dirVec = Vector2(1,-1)
	dirVec.x = dirVec.x * rand_range(-1,1)*0.1

func _physics_process(delta):
	var collision = move_and_collide(dirVec*velocity)
	if collision:
		var reflect = collision.remainder.bounce(collision.normal)
		dirVec = dirVec.bounce(collision.normal)
		move_and_collide(reflect)
		if collision.collider.name.match('*TetrisBlock*'):
			collision.collider.destroy()

func _ready():
	randomize()
	castBall()

