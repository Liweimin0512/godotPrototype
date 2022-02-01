extends Node
class_name ComponentBase

var entity : Node

# func construct():
#     pass

func _ready():
	yield(owner,"ready")
