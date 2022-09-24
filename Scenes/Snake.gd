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

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_add_segment()

func _add_segment():
	var segment = segmentScene.instance()
	add_child(segment)
	segment.global_position = get_child(get_child_count()-2).global_position

func _physics_process(delta):
	update_positions_with_head_bottom_position(frame_counter)
	update_rotations_with_head_rotation(frame_counter)
	
	var segments = get_tree().get_nodes_in_group("segments")
	var i = 0
	for segment in segments:
		i += 1
		var segment_frame_idx = max(0, frame_counter + 1 -10 * i)
		segment.global_position.x = positions[segment_frame_idx].x
		segment.global_position.y = positions[segment_frame_idx].y
		segment.rotation = rotations[segment_frame_idx]
	frame_counter += 1
	
	var max_allowed_history_size = (segments.size() + 2) * 10
	if positions.size() > max_allowed_history_size:
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
