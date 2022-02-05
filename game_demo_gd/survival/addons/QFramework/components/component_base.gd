extends Node
class_name ComponentBase

var owner_prefab

export(bool) var is_alive = true

func _enter_tree():
	yield(owner,"tree_entered")
	owner_prefab = owner.owner
