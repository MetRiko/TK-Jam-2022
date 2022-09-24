extends Node2D

onready var particleContainer = get_tree().root.get_node("/root/ParticleContainer")

func addParticles(particles):
	particleContainer.add_child(particles)
