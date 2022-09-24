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
var segment_count: int = 6

var segmentScene = preload("res://Scenes/Segment.tscn")


func _ready():
	pass

func _physics_process(delta):
	update_positions_with_head_bottom_position(frame_counter)
	update_rotations_with_head_rotation(frame_counter)
	if frame_counter % 10 == 0 and segment_count > 0:
		add_child(segmentScene.instance())
		segment_count -= 1
	
	var segments = get_tree().get_nodes_in_group("segments")
	var i = 0
	for segment in segments:
		i += 1
		var segment_frame_idx = max(0, frame_counter +1 -10 * i)
		print(segment_frame_idx)
		segment.global_position.x = positions[segment_frame_idx].x
		segment.global_position.y = positions[segment_frame_idx].y
		segment.rotation = rotations[segment_frame_idx]
	frame_counter += 1
	if positions.size() == segments.size() * 100:
		positions.clear()
		frame_counter = 0

func update_positions_with_head_bottom_position(frame_count: int):
	var head_bottom = get_tree().get_nodes_in_group("head_bottom")[0]
	var position_obj = Position.new(
		head_bottom.global_position.x,
		head_bottom.global_position.y
	)
	positions[frame_count] = position_obj
	
func update_rotations_with_head_rotation(frame_count: int):
	var head = get_tree().get_nodes_in_group("head")[0]
	rotations[frame_count] = head.rotation
