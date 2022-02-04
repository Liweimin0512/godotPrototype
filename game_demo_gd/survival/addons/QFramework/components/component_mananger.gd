extends Node
class_name ComponetManager

var components := {}
var components_path = "res://components/"

func _ready():
	yield(owner,"ready")
	for child in get_children():
		if child is ComponentBase:
			components[child.name] = child
			child.owner_prefab = owner
		else:
			printerr("is not component")

func add_component(component_name : String):
	var cmp : ComponentBase = load(components_path + component_name + ".gd").new()
	cmp.owner_prefab = owner
	self.add_child(cmp)
	self.components[name] = cmp