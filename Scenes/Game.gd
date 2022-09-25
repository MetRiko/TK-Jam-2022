extends Node2D

var levelInstance = preload("res://Scenes/Level.tscn").instance()

onready var particleContainer = get_tree().root.get_node("Root/ParticleContainer")
onready var level = get_tree().root.get_node("Root/Level")
onready var audioPlayer = get_tree().root.get_node("Root/AudioPlayer")
onready var ds = get_tree().root.get_node("Root/DeathScreen")

var dead = false
var highscore = 0

func _ready():
	ds.hide()

func addParticles(particles):
	particleContainer.add_child(particles)

func getLevel():
	return get_tree().root.get_node("Root/Level")

func addBall(ball):
	getLevel().addBall(ball)

func die():
	ds.show()
	var score = level.getCounter().text
	ds.get_child(2).text = score
	if int(score) > int(highscore):
		highscore = score
		level.getCounter2().text = score
	dead = true

func _input(event):
	if dead and event is InputEventKey:
		reset()


func reset():
	ds.hide()
	#clear previous level
	pass
