# provides the ability to manage entities and groups of entities, 
# where an entity is defined as any dynamically created objects 
# in the game scene. It shows or hides entities, 
# attach one entity to another (such as weapons, horses or snatching up another entity). 
# Entities could avoid being destroyed instantly after use, 
# and hence be recycled for reuse

extends Node
# class_name EntityManager

var _entity_GUID := 0
var entity_path = "res://entities/"

signal create_entity_completed

func create_entity(entity_name :String,pos: Vector2):
	var res_loader = QInstance.get_res_loader()
	var res_paths = []
	if entity_name == "":
		return
	res_paths.append(entity_path + entity_name + ".tscn")
	var res = yield(res_loader.load_start(res_paths),"completed")
	var entity = res[0].instance()
	entity.position = pos
	self.add_child(entity)
#	self.GUID = EntityManager.get_GUID()
	self.emit_signal("create_entity_completed",entity)

func get_GUID() -> int:
	_entity_GUID += 1
	return _entity_GUID
