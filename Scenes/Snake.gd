extends Node2D

class Position:
	var x: float
	var y: float
	func _init(x: float, y: float):
		self.x = x
		self.y = y

var positions: Dictionary = {}
var rotations: Dictionary = {}
var frame_counter: int = 0

var segmentScene = preload("res://Scenes/Segment.tscn")

onready var snakeHead = $SnakeHead
onready var body = $Body

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_add_segment()
	if event.is_action_pressed("ui_down"):
		_remove_front_segment()

func _add_segment():
	var segment = segmentScene.instance()
	body.add_child(segment)
	segment.global_position = Vector2(-1, -1) * 100.0
	
func _remove_front_segment():
	var removed_segment = body.get_child(0)
	snakeHead.global_position = removed_segment.global_position
#	snakeHead.direction = Vector2.LEFT.rotated(removed_segment.global_rotation)
	removed_segment.queue_free()
	body.remove_child(removed_segment)
	for i in range(10):
		var frame_to_remove = frame_counter - 1 - i
		positions.erase(frame_to_remove)
		rotations.erase(frame_to_remove)
	frame_counter -= 10

func _physics_process(delta):
	update_positions_with_head_bottom_position(frame_counter)
	update_rotations_with_head_rotation(frame_counter)
	
	var i = 0
	for segment in body.get_children():
		i += 1
		var segment_frame_idx = max(0, frame_counter + 1 - 10 * i)
		segment.global_position.x = positions[segment_frame_idx].x
		segment.global_position.y = positions[segment_frame_idx].y
		segment.rotation = rotations[segment_frame_idx]
	frame_counter += 1
	
	var max_allowed_history_size = (body.get_child_count() + 2) * 10
	while positions.size() > max_allowed_history_size:
		var key = frame_counter - positions.size() + 1
		positions.erase(key)
		rotations.erase(key)

func update_positions_with_head_bottom_position(frame_count: int):
	var position_obj = Position.new(
		snakeHead.global_position.x,
		snakeHead.global_position.y
	)
	positions[frame_count] = position_obj
	
func update_rotations_with_head_rotation(frame_count: int):
	rotations[frame_count] = snakeHead.rotation
