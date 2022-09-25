extends Area2D

func _ready():
	connect("body_entered",self,"onBodyEntered")

func onBodyEntered(body):
	var bodies = get_overlapping_bodies()
	for b in bodies:
		b.call_deferred("destroy")
	queue_free()
