extends Node2D

onready var balls = $Balls

func addBall(ball):
	balls.add_child(ball)
