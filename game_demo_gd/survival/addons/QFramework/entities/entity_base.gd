extends Node
class_name EntityBase

var game_scene

func _ready():
	yield(owner,"ready")

func create_entity():
	var ins = game_scene.instance()
	self.add_child(ins)
