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
var _entities := {}

func create_entity(entity_name :String,pos: Vector2):
	var entity = load(entity_path + entity_name + ".gd").new()
	self.add_child(entity)
#	entity.entity_manager = self
	entity.create_entity(pos)
	_entities[entity_name] = entity
	return entity

func get_GUID() -> int:
	_entity_GUID += 1
	return _entity_GUID
