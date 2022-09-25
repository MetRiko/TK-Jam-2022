extends CanvasLayer


signal screen_covered

func _ready():
	visible = !visible

func emit_screen_cover():
	emit_signal("screen_covered")
