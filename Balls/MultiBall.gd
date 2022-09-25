extends BallBase

const commonBall = preload("res://Balls/SmallBall.tscn")

func _on_block_collision(block):
	spawnBalls()
	block.destroy()
	queue_free()
	
func _on_snake_collision(snake_segment):
	velocity = 5.0

func _on_any_collision(collision : KinematicCollision2D):
	var reflect = collision.remainder.bounce(collision.normal)
	bounce(collision.normal)
	move_and_collide(reflect, false)

func spawnBalls():
	var ball = commonBall.instance()
	var ball2 = commonBall.instance()
	Game.addBall(ball)
	Game.addBall(ball2)
	ball.set_color($Sprite.modulate)
	ball2.set_color($Sprite.modulate)
	ball.global_position = global_position + Vector2(0,-1)
	ball.dirVec = dirVec + Vector2(0.7,0);
	ball2.global_position = global_position + Vector2(0,-2)
	ball2.dirVec = dirVec + Vector2(-0.7,0);
