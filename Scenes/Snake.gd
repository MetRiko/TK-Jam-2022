extends Node2D

class SegmentData:
	var x: float
	var y: float
	var angle: float
	func _init(x: float, y: float, angle: float):
		self.x = x
		self.y = y
		self.angle = angle

var history: Dictionary = {}
var frame_counter: int = 0

var segments_gap := 25
var speedMultiplier := 3

var segmentScene = preload("res://Scenes/Segment.tscn")

onready var snakeHead = $SnakeHead
onready var body = $Body

func _ready():
	for i in range(3):
		_add_segment()

func _input(event):
	if event.is_action_pressed("ui_up"):
		speedMultiplier = 6
	if event.is_action_released("ui_up"):
		speedMultiplier = 3

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
	for i in range(segments_gap):
		var frame_to_remove = frame_counter - 1 - i
		history.erase(frame_to_remove)
	frame_counter -= segments_gap

#func _process(delta):
#	if Input.is_action_pressed("ui_up"):

func _physics_process(delta):
	if snakeHead.alive:
		snakeHead._rotation_update(delta)
		for i in range(speedMultiplier):
			_single_update(delta)

func _single_update(delta):
	snakeHead._movement_update(delta)
	
	update_positions_with_head_bottom_position(frame_counter)
	
	var i = 0
	for segment in body.get_children():
		i += 1
		var segment_frame_idx = max(0, frame_counter + 1 - segments_gap * i)
		var seg = history.get(segment_frame_idx, null)
		if seg == null:
			seg = history.values()[0]
		segment.global_position.x = seg.x
		segment.global_position.y = seg.y
		segment.rotation = seg.angle
	frame_counter += 1
	
	var max_allowed_history_size = (body.get_child_count() + 1) * segments_gap
	while history.size() > max_allowed_history_size:
		var key = frame_counter - history.size()
		history.erase(key)
		
#	print(history.keys())

func update_positions_with_head_bottom_position(frame_count: int):
	var position_obj = SegmentData.new(
		snakeHead.global_position.x,
		snakeHead.global_position.y,
		snakeHead.rotation
	)
	history[frame_count] = position_obj
