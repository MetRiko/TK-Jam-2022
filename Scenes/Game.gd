extends Node2D

onready var particleContainer = get_tree().root.get_node("Root/ParticleContainer")
onready var level = get_tree().root.get_node("Root/ParticleContainer")

func addParticles(particles):
	particleContainer.add_child(particles)

func getLevel():
	return get_tree().root.get_node("Root/Level")

func addBall(ball):
	getLevel().addBall(ball)
