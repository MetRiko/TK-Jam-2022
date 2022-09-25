extends Node

func _shoot():
	if get_parent().body.get_child_count() > 0:
		var head = get_parent().snakeHead
		var front_segment = get_parent().body.get_child(0)
		var ball = head.segment_type[1].instance()
		ball.set_color(head.get_color())
		Game.addBall(ball)
		AudioPlayer.playSound(0)
		ball.dirVec = head.direction
		ball.global_position = front_segment.global_position + head.direction * 15.0
		ball.velocity = 5.0
		get_parent()._remove_front_segment()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_shoot()
		
