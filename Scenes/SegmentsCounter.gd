extends Label

var blocksToDestroy = 5
var destroyedBlocks = blocksToDestroy 


func onDestroyBlock():
	
	destroyedBlocks-=1
	if destroyedBlocks==0:
		if Game.getLevel().getSnake().body.get_child_count() <= 20:
			Game.getLevel().getSnake()._add_segment()
		destroyedBlocks = blocksToDestroy
		blocksToDestroy = blocksToDestroy + 1
	text = String(destroyedBlocks)
