extends Node

var players :Array
var turn_player_count = 0


var paiku = []

func _ready():
	# 四个选手
	for i in range(0,4):
		var player = Player.new()
		player.playerID = i
		players.append(player)
		add_child(player)
	
	# 洗牌
	mapai()
	
	
	# 发牌
	for p in players:
		p.add_handpais(zhuapai(13))
		
	# 检查是否有人听牌
	
	


func get_next_player():
	pass	

# 码牌
func mapai():
	paiku = []
	for i in range(0,4):
		for x in range(0,3):
			for y in range(1,10):
				paiku.append(x*10+y)
	print(paiku)

func zhuapai(num = 1):	
	if num == 1:
		var r = rand_range(0,paiku.size())
		var pai = paiku[r]
		paiku.remove(r)
		return pai
	else:
		var pais = []
		for n in range(0,num):
			var r = rand_range(0,paiku.size())
			var pai = paiku[r]
			paiku.remove(r)
			pais.append(pai)
		return pais
			
