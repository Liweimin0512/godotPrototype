extends Node

var players :Array
var zhuangjia_num = 0 # 庄家编号
var turn_num = 0 # 当前wanjaihuihe
var paiku = []

signal check_ting

func _ready():

	connect("check_ting",self,"on_check_ting")

	begin_play()

func begin_play():
	var zhuangjia_num = int(rand_range(0,4))
	print("庄家num：", zhuangjia_num)
	turn_num = zhuangjia_num
	# 四个选手
	for i in range(0,4):
		var player = Player.new()
		player.playerID = i
		# if i == 0:
		# 	player.is_AI = false
		players.append(player)
		add_child(player)
	
	# 洗牌
	mapai()
	
	# 发牌
	for p in players:
		p.add_handpais(zhuapai(13))
		
	# 检查是否有人听牌
	get_turn_player().check_tingpai()
	
	# 检查是否有人杠牌

	
	# 轮询是否有人碰牌或杠牌

	# 下家是否吃牌

	# 

func get_turn_player() -> Player:
	return players[turn_num]

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
			
#################################

func on_check_ting(player,can_ting):
	print("玩家",String(player.playerID),"没有听牌")
	if player.get_next_player().playerID == turn_num:
		print("轮训一遍之后，当前玩家抓牌")		
		get_turn_player().add_handpais(zhuapai(1))
	else:
		player.get_next_player().check_tingpai()
