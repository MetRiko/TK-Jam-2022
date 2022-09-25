extends Area2D

func _on_DeathTrigger_body_entered(body):
	if body.name.match('SnakeHead'):
		Game.die()
