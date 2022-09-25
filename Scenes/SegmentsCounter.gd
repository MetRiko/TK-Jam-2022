extends Label

var destroyedBlocks = 6

func onDestroyBlock():
	destroyedBlocks-=1
	if destroyedBlocks==0:
		Game.getLevel().getSnake()._add_segment()
		destroyedBlocks = 6
	text = String(destroyedBlocks)
