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

func playSound(soundName):
	for streams in streamList:
		if(soundName == streams.resource_name):
			currStream = streams
	$EffectsAudioStreamPlayer.stream = currStream
	$EffectsAudioStreamPlayer.play()
