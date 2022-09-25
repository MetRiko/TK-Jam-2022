extends KinematicBody2D
class_name SnakeSegment

const segments_tex = preload("res://Snake/snake_segments.png")

var segment_type = null

func get_color():
	return $Sprite.modulate

func set_color(color : Color):
	$Sprite.modulate = color

func _ready():
	if is_in_group('segments'):
		$Anim.play("init")

func set_segment_type(segment_type):
	self.segment_type = segment_type

func set_sprite_from_segment_type():
	$Sprite.texture = segments_tex
	$Sprite.hframes = 12
	if segment_type == null:
		$Sprite.frame = 0
	else:
		$Sprite.frame = segment_type[0]
	
