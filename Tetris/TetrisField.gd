extends Node2D

const block_scene = preload("res://Tetris/TetrisBlock.tscn")
const block_size := Vector2(16, 16)
onready var blocks = $Blocks

var offset_y := 0.0
var start_pos := Vector2()
var height_level_per_column := [0, 0, 0, 0, 0, 0]
var current_max_height = 0

const blocks_groups = [
	#Cube
	[Vector2(0,0), Vector2(1,0), Vector2(0,1), Vector2(1,1)],

	#Line
	[Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(3,0)],
	[Vector2(0,0), Vector2(0,1), Vector2(0,2), Vector2(0,3)],

	#T-block
	[Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(1,1)],
	[Vector2(1,0), Vector2(1,1), Vector2(2,1), Vector2(0,1)],
	[Vector2(0,1), Vector2(1,0), Vector2(1,1), Vector2(1,2)],
	[Vector2(0,0), Vector2(0,1), Vector2(0,2), Vector2(1,1)],

	#S-block
	[Vector2(0,0), Vector2(1,0), Vector2(1,1), Vector2(2,1)],
	[Vector2(0,1), Vector2(1,1), Vector2(1,0), Vector2(2,0)],
	[Vector2(1,0), Vector2(0,1), Vector2(1,1), Vector2(0,2)],
	[Vector2(0,0), Vector2(0,1), Vector2(1,1), Vector2(1,2)],

	#L-block-1
	[Vector2(0,0), Vector2(1,0), Vector2(1,1), Vector2(1,2)],
	[Vector2(0,0), Vector2(0,1), Vector2(1,1), Vector2(2,1)],
	[Vector2(0,0), Vector2(0,1), Vector2(0,2), Vector2(1,2)],
	[Vector2(0,0), Vector2(1,0), Vector2(0,1), Vector2(2,0)],

	#L-block-2
	[Vector2(0,0), Vector2(1,0), Vector2(0,1), Vector2(0,2)],
	[Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(2,1)],
	[Vector2(1,0), Vector2(1,1), Vector2(1,2), Vector2(0,2)],
	[Vector2(0,0), Vector2(0,1), Vector2(1,1), Vector2(2,1)],
]

func _physics_process(delta):
	offset_y += 20.0 * delta
	blocks.position.y = start_pos.y - offset_y

func _ready():
	randomize()
	start_pos = blocks.position
	_set_columns_amount(31)
	$SpawnTimer.connect("timeout", self, "put_random_blocks_group_below")

func _set_columns_amount(amount : int) -> void:
	height_level_per_column.resize(amount)
	for i in range(height_level_per_column.size()):
		height_level_per_column[i] = 0

func can_put_blocks_group_below(idx_x : int, blocks_idxes : Array) -> bool:
	var start_height = height_level_per_column[idx_x]
	for idx in blocks_idxes:
		var target_idx_x = idx_x + idx.x
		if target_idx_x >= height_level_per_column.size():
			return false
		if height_level_per_column[target_idx_x] > start_height + idx.y:
			return false
	return true
	
func get_blocks_group_fit_height(idx_x : int, blocks_idxes : Array) -> int:
	for idx in blocks_idxes:
		if idx_x + idx.x >= height_level_per_column.size():
			return -1
	var group_height = 0
	for idx in blocks_idxes:
		group_height = max(group_height, idx.y)
	group_height += 1
	var start_height = height_level_per_column[idx_x] - 1 - group_height
	var finished := false
	while not finished:
		finished = true
		start_height += 1
		for idx in blocks_idxes:
			if height_level_per_column[idx_x + idx.x] >= start_height + idx.y:
				finished = false
	return start_height

func put_blocks_group(idx_x : int, start_height : int, blocks_idxes : Array) -> void:
	var color = Color(randf() * 0.5 + 0.5, randf() * 0.5 + 0.5, randf() * 0.5 + 0.5, 1.0)
	var in_blocks = []
	var in_offsets = {}
	var latest_block = null
	for idx in blocks_idxes:
		var block = block_scene.instance()
		blocks.add_child(block)
		block.setup(idx, in_offsets, in_blocks)
		block.change_color(color)
		latest_block = block
		var target_idx = Vector2(idx_x + idx.x, start_height + idx.y)
		block.position = idx_to_pos(target_idx)
		height_level_per_column[target_idx.x] = max(height_level_per_column[idx_x], target_idx.y)
	latest_block.update_variants()
	
	var chance = randf()
	if chance < 0.2:
		in_blocks[randi() % in_blocks.size()].add_bonus(null)
	
	
func put_random_blocks_group_below():
	if current_max_height * block_size.y > $BottomLimit.position.y + offset_y - start_pos.y:
		return
	
#	var idx_x = randi() % height_level_per_column.size()
#	var blocks_group = [Vector2(0,0), Vector2(1,0), Vector2(0,1), Vector2(0,2)]
	var blocks_group = blocks_groups[randi() % blocks_groups.size()]
	var heights = []
	heights.resize(height_level_per_column.size())
	var min_height = 100000000
	for idx_x in range(height_level_per_column.size()):
		var height = get_blocks_group_fit_height(idx_x, blocks_group)
		if height != -1:
			min_height = min(min_height, height)
		heights[idx_x] = height
	
	var min_heights = []
	for idx_x in range(heights.size()):
		var height = heights[idx_x]
		if height == min_height:
			min_heights.append(idx_x)
	
	var target_idx_x = min_heights[randi() % min_heights.size()]
#	var target_height = get_blocks_group_fit_height(target_idx_x, blocks_group)
#	if target_height != -1:
	put_blocks_group(target_idx_x, min_height, blocks_group)
	var block_height := 0
	for height in height_level_per_column:
		block_height = max(block_height, int(height))
	block_height += 1
	current_max_height = max(current_max_height, block_height)
		
#	if can_put_blocks_group_below(idx_x, blocks_group):

func _input(event):
	if event.is_action_pressed("ui_accept"):
		put_random_block()
	if event.is_action_pressed("ui_down"):
		put_random_blocks_group_below()
#		print(height_level_per_column)

func put_block_below(idx_x : int) -> void:
	var block = block_scene.instance()
	blocks.add_child(block)
	block.position = idx_to_pos(Vector2(idx_x, height_level_per_column[idx_x]))
	height_level_per_column[idx_x] += 1
	
func put_random_block() -> void:
	var idx_x := randi() % height_level_per_column.size()
	put_block_below(idx_x)
	
func idx_to_pos(idx : Vector2) -> Vector2:
	return idx * block_size
	
func pos_to_idx(pos : Vector2):
	pass
