extends Node


var arr_pais = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func can_ting():
	var n_gupai = 0
	var arr = arr_pais.sort()
	# 遍历所有牌
	for pai_num in range(arr):
		# 能否组成顺子
		if arr[pai_num + 1] == arr[pai_num] + 1 and arr[pai_num + 2] == arr[pai_num] + 2:
			arr.remov
		# 能否组成刻子
		# 能否组成对子
		
		# 都不能
		n_gupai += 1
		if n_gupai >= 4 :
			return false
		


func get_shunzi(pai_num:int) -> Array:
	var shunzi = []
	var arr = arr_pais.sort()
	if arr[pai_num + 1] == arr[pai_num] + 1 and arr[pai_num + 2] == arr[pai_num] + 2:
		shunzi.append(arr[pai_num])
		shunzi.append(arr[pai_num + 1])
		shunzi.append(arr[pai_num + 2])		
	return shunzi


func get_peng(pai_num:int):
	var kezi = []
	var arr = arr_pais.sort()
	if arr[pai_num + 1] == arr[pai_num] and arr[pai_num + 2] == arr[pai_num]:
		kezi.append(arr[pai_num])
		kezi.append(arr[pai_num + 1])
		kezi.append(arr[pai_num + 2])		
	return kezi
		
