extends KinematicBody2D

var velocity = 1.2
var dirVec = Vector2.ZERO

#func castBall():
#	dirVec = Vector2(1,1)
#	dirVec.x = dirVec.x * rand_range(-1,1)*0.1


var collidable := false

func _ready():
	yield(get_tree().create_timer(0.08), "timeout")
	collidable = true
	
func bounce(normal : Vector2):
	dirVec = dirVec.bounce(normal)

func _physics_process(delta):
	var collision = move_and_collide(dirVec*velocity)
	if collision:
		if collision.collider.is_in_group("balls_destroyer"):
			AudioPlayer.playSound(3)
			queue_free()
			return
		var reflect = collision.remainder.bounce(collision.normal)
		bounce(collision.normal)
		move_and_collide(reflect, false)
		if collision.collider.is_in_group("snake"):
			randomize()
			AudioPlayer.playSound(int(rand_range(1,2)))
			velocity = 5.0
		if collision.collider.name.match('*TetrisBlock*'):
			collision.collider.destroy()
			velocity = 1.5
