extends KinematicBody2D

const commonBall = preload("res://Scenes/SmallBall.tscn")

var velocity = 1.2
var dirVec = Vector2.ZERO

#func castBall():
#	dirVec = Vector2(1,1)
#	dirVec.x = dirVec.x * rand_range(-1,1)*0.1

func bounce(normal : Vector2):
	dirVec = dirVec.bounce(normal)

func _physics_process(delta):
	var collision = move_and_collide(dirVec*velocity)
	if collision:
		if collision.collider.is_in_group("balls_destroyer"):
			queue_free()
			return
		var reflect = collision.remainder.bounce(collision.normal)
		bounce(collision.normal)
		move_and_collide(reflect, false)
		if collision.collider.is_in_group("snake"):
			velocity = 5.0
		if collision.collider.name.match('*TetrisBlock*'):
			spawnBalls()
			collision.collider.destroy()
			queue_free()

func spawnBalls():
	var ball = commonBall.instance()
	var ball2 = commonBall.instance()
	Game.addBall(ball)
	Game.addBall(ball2)
	ball.global_position = global_position + Vector2(0,-1)
	ball.dirVec = dirVec + Vector2(0.7,0);
	ball2.global_position = global_position + Vector2(0,-2)
	ball2.dirVec = dirVec + Vector2(-0.7,0);
