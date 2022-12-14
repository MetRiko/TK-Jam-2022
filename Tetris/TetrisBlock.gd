extends KinematicBody2D

var pos_offset := Vector2()
var block_id = 0

const particles = preload("res://Tetris/Particles2D.tscn")

var blockColor
signal destroy_block

var blocks_offsets := {}
var blocks := []

var bonus = null

func _ready():
	$ShinyEffect.visible = false

func _process(delta):
	if global_position.y < -72:
		destroy()

func setup(pos_offset : Vector2, in_blocks_offsets : Dictionary, in_blocks : Array) -> void:
	block_id = in_blocks.size()
	self.pos_offset = pos_offset
	blocks_offsets = in_blocks_offsets
	in_blocks_offsets[_hash_idx(pos_offset)] = true
	blocks = in_blocks
	in_blocks.append(self)

func add_bonus(bonus):
#	var color = Color(randf() * 0.5 + 0.5, randf() * 0.5 + 0.5, randf() * 0.5 + 0.5, 1.0)
	var color = Color.from_hsv(randf(), 0.8, 1.0, 1.0)
	for block in blocks:
		if block:
			block.change_color(color)
	self.bonus = bonus
	$ShinyEffect.visible = true
	$Anim.play("shiny_effect")
	
func update_variants():
	for block in blocks:
		if block != null:
			block._update_variant()
	
func destroy():
	if blocks[block_id] == null:
		return
	var part = particles.instance()
	if $ShinyEffect.visible == true:
		Game.getLevel().getCounter().addPoints(100)
	else:
		 Game.getLevel().getCounter().addPoints(10)
	Game.addParticles(part)
	AudioPlayer.playSound(2)
	part.global_position = global_position + Vector2(8,8)
	part.modulate = Color.from_hsv(blockColor.h, 0.8, 1.0, 1.0)
	part.emitting = true
	if bonus != null:
		var seg = Game.getLevel().getSnake()._add_segment(bonus)
		seg.set_color(blockColor)
		for block in blocks:
			if block != null:
				block.change_color(Color.from_hsv(blockColor.h, 0.5, 0.45, 1.0))
	Game.getLevel().get_node("Segments").onDestroyBlock()
	blocks_offsets.erase(_hash_idx(pos_offset))
	blocks[block_id] = null
	update_variants()
	queue_free()

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			var rect = Rect2(global_position, Vector2.ONE * 16)
#			if rect.has_point(get_global_mouse_position()):
#				destroy()
	
func check_variant_id() -> int:
	var up := int(blocks_offsets.has(_hash_idx(pos_offset + Vector2.UP))) * 1
	var right := int(blocks_offsets.has(_hash_idx(pos_offset + Vector2.RIGHT))) * 2
	var left := int(blocks_offsets.has(_hash_idx(pos_offset + Vector2.LEFT))) * 8
	var down := int(blocks_offsets.has(_hash_idx(pos_offset + Vector2.DOWN))) * 4
	var pattern = up + down + left + right
	match pattern:
		0: return 0
		1: return 3
		2: return 4
		3: return 7
		4: return 1
		6: return 8
		8: return 2
		9: return 6
		12: return 5
		10: return 9
		5: return 10
		14: return 11
		13: return 12
		11: return 13
		7: return 14
		_: return 0

func set_variant(variant_id : int) -> void:
	$Sprite.frame = variant_id
	
func _update_variant() -> void:
	set_variant(check_variant_id())

func _hash_idx(idx : Vector2) -> int:
	return int(idx.x + idx.y * 1000)

func change_color(color : Color) -> void:
	$Sprite.modulate = color
	$ShinyEffect.modulate = color
	blockColor = color
