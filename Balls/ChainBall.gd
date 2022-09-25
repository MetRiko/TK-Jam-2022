extends BallBase

var chain_active = false

func _ready():
	._ready()
	$Timer.connect("timeout", self, "kill")

func kill():
	queue_free()

func activate_chain():
	if chain_active == false:
		$Timer.start()
		chain_active = true

func _on_block_collision(block):
	activate_chain()
	block.destroy()
	
func _on_snake_collision(snake_segment):
	velocity = 5.0

func _on_any_collision(collision : KinematicCollision2D):
	var reflect = collision.remainder.bounce(collision.normal)
	bounce(collision.normal)
	move_and_collide(reflect, false)

func _physics_process(delta):
	._physics_process(delta)
	if chain_active:
		velocity = 4.0
		dirVec = Vector2.DOWN.rotated(rand_range(-0.4, 0.4))
