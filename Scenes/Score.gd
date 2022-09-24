extends Label

var currScore = 0

func addPoints(points):
	currScore += points

func _process(delta):
	text = String(currScore)
