extends Node

onready var maxVol
var currStream
export(Array,AudioStreamSample) var streamList 

func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
		maxVol = $AudioStreamPlayer.volume_db

func changeVolume(volume):
	volume = volume*100/maxVol
	$AudioStreamPlayer.volume_db = volume

func playSound(soundIdx):
	currStream = streamList[soundIdx]
	$EffectsAudioStreamPlayer.stream = currStream
	$EffectsAudioStreamPlayer.play()
