extends SnakeSegment

const filled_segments_tex = preload("res://Snake/filled_segments.png")

var direction: Vector2 = Vector2.DOWN
var velocity: int = 30
var rotationAngle: float = deg2rad(3.5)
var forward_vector = Vector2(0,1)
var the_object = self

var alive := true

func set_sprite_from_segment_type():
	$Sprite.texture = filled_segments_tex
	$Sprite.hframes = 12
	if segment_type == null:
		$Sprite.frame = 0
	else:
		$Sprite.frame = segment_type[0]
		
func apply_segment(segment):
	$Sprite.modulate = segment.get_node("Sprite").modulate
	segment_type = segment.segment_type
	set_sprite_from_segment_type()

func _ready():
	set_segment_type(get_parent().standard_type)
	set_sprite_from_segment_type()
	$CollisionDetector.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	return
	if alive and body != self:
		alive = false
		print("Game over!")

func _movement_update(delta):
	if alive:
		var velocity_vec: Vector2 = get_linear_velocity()
		velocity_vec = move_and_slide(velocity_vec, Vector2.ZERO)
		if get_slide_count() > 0:
			var coll = get_slide_collision(0)
			AudioPlayer.playSound(4)
			if coll and coll.collider.is_in_group("ball") and coll.collider.collidable:
				var ball = coll.collider
				ball.velocity = 5.0
				ball.dirVec = direction
				direction = -direction

func _rotation_update(delta : float):
	if Input.is_action_pressed("ui_right"):
		var angle = rotationAngle * delta * 60.0
		direction = direction.rotated(angle)
		rotate(angle)
	if Input.is_action_pressed("ui_left"):
		var angle = -rotationAngle * delta * 60.0
		direction = direction.rotated(angle)
		rotate(angle)

func get_linear_velocity():
	var linear_velocity: Vector2
	linear_velocity.x = direction.x * velocity
	linear_velocity.y = direction.y * velocity
	return linear_velocity

