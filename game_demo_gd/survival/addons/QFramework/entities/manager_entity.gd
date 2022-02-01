# provides the ability to manage entities and groups of entities, 
# where an entity is defined as any dynamically created objects 
# in the game scene. It shows or hides entities, 
# attach one entity to another (such as weapons, horses or snatching up another entity). 
# Entities could avoid being destroyed instantly after use, 
# and hence be recycled for reuse

extends Node
class_name EntityManager

var _entities : Dictionary = {}
var _entity_GUID := 0

func create_entity(entity_name :String,pos: Vector2):
	var entity = _entities[entity_name].new()
	self.add_child(entity)
	entity.entity_manager = self
	entity.create_entity(pos)

#func create_build():
#	var build = BuildBase.new()
#	build.add_to_group("build")
#	self.add_child(build)
func register_entity(entity_name:String, entity_path:String):
	var entity : Resource = load(entity_path)
	self._entities[entity_name] = entity

func get_GUID() -> int:
	_entity_GUID += 1
	return _entity_GUID
