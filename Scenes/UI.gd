extends CanvasLayer


func get_highscore_label():
	return $HighScoreLabel
	
func get_start_button():
	return $ButtonContainer/Start/Start
	

func _on_Start_pressed():
	Game.start_game()
