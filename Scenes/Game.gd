extends Node2D

const levelPrefab = preload("res://Scenes/Level.tscn")
const transitionPrefab = preload("res://Scenes/ScreenTransition.tscn")

onready var particleContainer = get_tree().root.get_node("Root/ParticleContainer")
onready var level = get_tree().root.get_node("Root/Level")
onready var ds = get_tree().root.get_node("Root/DeathScreen")
onready var ui = get_tree().root.get_node("Root/UI")

var dead = false
var highscore = 0

func _ready():
	reset()

func addParticles(particles):
	particleContainer.add_child(particles)

func getLevel():
	return level

func addBall(ball):
	getLevel().addBall(ball)

func die():
	if dead:
		return
	ds.show()
	getLevel().getSnake().snakeHead.alive = false
	getLevel().getTetrisField().isMoving = false
	var score = getLevel().getCounter().text
	ds.get_child(2).text = score
	if int(score) > int(highscore):
		highscore = score
	dead = true

func reset():
	ds.hide()
	getLevel().queue_free()
	ui.get_highscore_label().text = str(highscore)
	ui.show()

func start_game():
	ui.hide()
	var lvl = levelPrefab.instance()
	level = lvl
	level.getCounter2().text = str(highscore)
	var rt = get_tree().root.get_node("Root")
	rt.add_child_below_node(rt.get_child(0), lvl)
	dead = false
	pass
