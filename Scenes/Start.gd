extends Button


func _ready():
	connect("button_down", self, "on_button_pressed")
	connect("screen_covered", self, "on_screen_covered")
	
func on_button_pressed():
	$'/Root/CanvasLayer/AnimationPlayer'.play('default')
	
#func on_screen_covered():
#	$'/root/Root/UI'.visible = false	
