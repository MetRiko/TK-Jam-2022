extends Node

const ball_scn = preload("res://Scenes/Ball.tscn")

func _shoot():
	if get_parent().body.get_child_count() > 0:
		var head = get_parent().snakeHead
		var front_segment = get_parent().body.get_child(0)
		var ball = ball_scn.instance()
		Game.addBall(ball)
		ball.dirVec = Vector2.UP.rotated(head.global_rotation)
		ball.global_position = front_segment.global_position - ball.dirVec * 15.0
		ball.velocity = 5.0
		get_parent()._remove_front_segment()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_parent()._add_segment()
	if event.is_action_pressed("ui_down"):
		_shoot()
		
