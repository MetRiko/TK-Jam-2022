extends Node2D

const levelPrefab = preload("res://Scenes/Level.tscn")

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
	return level

func addBall(ball):
	getLevel().addBall(ball)

func die():
	ds.show()
	var score = getLevel().getCounter().text
	ds.get_child(2).text = score
	if int(score) > int(highscore):
		highscore = score
	dead = true

func _input(event):
	if dead and event.is_action_pressed("ui_up"):
		reset()


func reset():
	ds.hide()
	getLevel().queue_free()
	var lvl = levelPrefab.instance()
	level = lvl
	level.getCounter2().text = highscore
	var rt = get_tree().root.get_node("Root")
	rt.add_child_below_node(rt.get_child(0), lvl)
	dead = false
	pass
