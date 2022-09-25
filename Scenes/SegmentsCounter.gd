extends Label

var destroyedBlocks = 0

func onDestroyBlock():
	destroyedBlocks+=1
	if destroyedBlocks%6==0:
		Game.getLevel().getSnake()._add_segment()
	text = String(destroyedBlocks%6) +"/"+ String(6)
