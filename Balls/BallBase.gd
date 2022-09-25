extends KinematicBody2D
class_name BallBase

var velocity = 1.2
var dirVec = Vector2.ZERO

var collidable := false

#############

func _on_block_collision(block):
	block.destroy()
	velocity = 1.5
	
func _on_snake_collision(snake_segment):
	velocity = 5.0

func _on_any_collision(collision : KinematicCollision2D):
	var reflect = collision.remainder.bounce(collision.normal)
	bounce(collision.normal)
	move_and_collide(reflect, false)
	
#############

func set_color(color):
	$Sprite.modulate = color
	
func _ready():
	yield(get_tree().create_timer(0.08), "timeout")
	collidable = true
	
func bounce(normal : Vector2):
	dirVec = dirVec.bounce(normal)

func _physics_process(delta):
	var collision = move_and_collide(dirVec*velocity)
	if collision:
		if collision.collider.is_in_group("balls_destroyer"):
			queue_free()
			return
		_on_any_collision(collision)
		if collision.collider.is_in_group("snake"):
			_on_snake_collision(collision.collider)
		if collision.collider.is_in_group('tetris_block'):
			_on_block_collision(collision.collider)
