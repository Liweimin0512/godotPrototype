extends Node
class_name ComponentBase

var owner_prefab

func _enter_tree():
	yield(owner,"ready")
