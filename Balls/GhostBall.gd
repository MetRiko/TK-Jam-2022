extends BallBase

var ghost_active = false

func toggle_ghost():
	ghost_active = not ghost_active
	if ghost_active:
		set_collision_mask_bit(3, false)
		$Sprite.modulate.a = 0.4
	else:
		set_collision_mask_bit(3, true)
		$Sprite.modulate.a = 1.0

#func castBall():
#	dirVec = Vector2(1,1)
#	dirVec.x = dirVec.x * rand_range(-1,1)*0.1

func _ready():
	._ready()
	toggle_ghost()
	$GhastTimer.connect("timeout", self, "_on_timeout")
	
func _on_timeout():
	toggle_ghost()
