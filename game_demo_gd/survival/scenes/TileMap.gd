extends TileMap

func _ready():
	for i in range(100):
		for j in range(100):
			self.set_cell(i,j,0)

