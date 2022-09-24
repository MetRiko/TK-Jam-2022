extends Node

onready var maxVol

func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
		maxVol = $AudioStreamPlayer.volume_db
	pass

func changeVolume(volume):
	volume = volume*100/maxVol
	$AudioStreamPlayer.volume_db = volume
