extends Label

var destroyedBlocks = 0
onready var segmentCount = 4

func onDestroyBlock():
	destroyedBlocks+=1
	if segmentCount+1*2 == destroyedBlocks:
		get_tree().root.get_node("Root").get_node("Snake")._add_segment()
		segmentCount = segmentCount*2
	text = String(destroyedBlocks) +"/"+ String(segmentCount+1*2)
