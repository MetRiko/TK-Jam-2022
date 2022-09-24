extends KinematicBody2D

var velocity = 1.2
var dirVec = Vector2.ZERO

const particles = preload("res://Scenes/Explosion.tscn")

#func castBall():
#	dirVec = Vector2(1,1)
#	dirVec.x = dirVec.x * rand_range(-1,1)*0.1

func _physics_process(delta):
	var collision = move_and_collide(dirVec*velocity)
	if collision:
		if collision.collider.is_in_group("balls_destroyer"):
			queue_free()
			return
		var reflect = collision.remainder.bounce(collision.normal)
		dirVec = dirVec.bounce(collision.normal)
		move_and_collide(reflect)
		if collision.collider.is_in_group("snake"):
			velocity = 5.0
		if collision.collider.name.match('*TetrisBlock*'):
			explode()
			velocity = 1.5

func explode():
	var explosion = particles.instance()
	Game.addParticles(explosion)
	explosion.global_position = global_position
#func _ready():
#	randomize()
#	castBall()

