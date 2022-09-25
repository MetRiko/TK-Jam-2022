extends Node2D

onready var balls = $Balls

func addBall(ball):
	balls.add_child(ball)

func getCounter():
	return $Score

func getCounter2():
	return $Score2

func _ready():
	var score = getCounter2()
	score = Game.highscore
