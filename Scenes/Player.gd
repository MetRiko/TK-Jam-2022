extends KinematicBody2D

var dirVec = Vector2(1,0)
var angle = 0.03
var velocity = 4000.0

func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		dirVec = dirVec.rotated(-angle)
	if(Input.is_action_pressed("ui_right")):
		dirVec = dirVec.rotated(angle)
	move_and_slide(dirVec*velocity*delta)


func getMyPos():
	return global_position

