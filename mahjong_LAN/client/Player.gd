class_name Player

extends Node

var playerID
var _handpais = []
var _pais_ming = [] # 亮出的牌
var _pais_an = [] # 手牌
var _pais_dachu = [] # 打出的牌

var is_AI :bool = true

enum player_state {
	normal,
	qiangting,
	ting,
	hu,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_next_player():
	if playerID >= 3:
		return GameInstance.players[0]
	else:
		return GameInstance.players[playerID + 1]


func check_tingpai():
	# 检查是否听牌
	# if is_AI == true:
	GameInstance.emit_signal("check_ting",self,false)
	# else:
	# 	var n_gupai = 0
	# 	var arr = _handpais.sort()
	# 	# 遍历所有牌
	# 	for pai_num in range(arr):
	# 		# 能否组成顺子
	# 		if arr[pai_num + 1] == arr[pai_num] + 1 and arr[pai_num + 2] == arr[pai_num] + 2:
	# 			arr.remov
	# 		# 能否组成刻子
	# 		# 能否组成对子
			
	# 		# 都不能
	# 		n_gupai += 1
	# 		if n_gupai >= 4 :
	# 			return false
		


func get_shunzi(pai_num:int) -> Array:
	var shunzi = []
	var arr = _handpais.sort()
	if arr[pai_num + 1] == arr[pai_num] + 1 and arr[pai_num + 2] == arr[pai_num] + 2:
		shunzi.append(arr[pai_num])
		shunzi.append(arr[pai_num + 1])
		shunzi.append(arr[pai_num + 2])		
	return shunzi


func get_peng(pai_num:int):
	var kezi = []
	var arr = _handpais.sort()
	if arr[pai_num + 1] == arr[pai_num] and arr[pai_num + 2] == arr[pai_num]:
		kezi.append(arr[pai_num])
		kezi.append(arr[pai_num + 1])
		kezi.append(arr[pai_num + 2])		
	return kezi
		
func add_handpais(pais):
	_handpais += pais
	print("玩家: ", String(playerID), "抓牌后手牌：", _handpais)

func on_turn():
	# 本轮抓牌

	# 如果听牌，检查是否胡牌

	# 本轮打牌
	pass