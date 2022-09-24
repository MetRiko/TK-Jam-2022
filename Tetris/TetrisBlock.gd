extends KinematicBody2D

var pos_offset := Vector2()

var blocks_offsets := {}

func setup(pos_offset : Vector2, blocks_group : Array) -> void:
	self.pos_offset = pos_offset
	for offset in blocks_group:
		blocks_offsets[_hash_idx(offset)] = null
	_update_variant()
	
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
