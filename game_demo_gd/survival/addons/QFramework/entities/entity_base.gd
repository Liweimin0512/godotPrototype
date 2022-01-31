extends Node
class_name EntityBase

var game_scene_path : String = ""

var _behaviour_trees := {}
var _state_graphs := {}
var _components := {}

var _updating_component := {}
var _stop_updating_components : Dictionary= {}
var entity_manager : EntityManager = null

var game_entity
var GUID := 0
var spawn_time := 0
var persists := true
var in_limbo := false

var name = null
var data = null
var listeners = null
var update_components = null
var inherent_actions = null
var event_listeners = null
var event_listening = null
var pending_tasks = null
var children = null
var age = 0

signal enter_limbo
signal exit_limbo

func _load_component(name, path):
	if _components[name] == null :
		_components[name] = load(path).new()
	return _components[name]

func _load_state_graph(name, path):
	if _state_graphs[name] == null:
		var fn = load(path).new()
		assert(fn,"could not load state graph" + name)
		_state_graphs[name] = fn
	var sg = _state_graphs[name]
	
	assert(sg, "state graph" + name + "is not valid")
	return sg

func create_entity(pos : Vector2):
	var res_loader = QInstance.get_res_loader()
	var res_paths = []
	if game_scene_path == "":
		return
	res_paths.append(game_scene_path)
	var res = yield(res_loader.load_start(res_paths),"completed")
	game_entity = res[0].instance()
	game_entity.position = pos
	self.add_child(game_entity)
	self.GUID = entity_manager.get_GUID()

func get_save_record():
	pass

func hide():
	self.game_entity.hide()

func show():
	self.game_entity.show()

func is_in_limbo():
	return self.in_limbo

func remove_from_scene():
	# 从场景中移除当前实体，并不会真的移除，而是将其隐藏在世界原点
	self.game_entity.add_to_group("IN_LIMBO")
	self.in_limbo = true
	self.game_entity.hide()

	self.stop_brain()
	
	if self.sg :
		self.sg.stop()
	if self.anim_state :
		anim_state.pause()
	if self.minimap_entity:
		self.minimap_entity.set_enabled(false)
	
	emit_signal("enter_limbo")

func return_to_scene():
	self.game_entity.remove_from_group("IN_LIMBO")
	self.in_limbo = false
	self.game_entity.show()
	if self.anim_state:
		self.anim_state.resume()
	if self.mimimap_entity:
		self.mimimap_entity.set_enabled(true)

	self.restart_brain()
	if self.sg :
		self.sg.start()

	emit_signal("exit_limbo")

func on_progress():
	for c_name in _components :
		if _components[c_name].has_function("on_progress"):
			_components[c_name].on_progress()

func _to_string():
	return String.format("%d - %s%s", self.GUID, self.prefab or "", self.inlimbo and "(LIMBO)" or "")

# func game_time_alive():
# 	return get_time() - self.spawn_time + self.age

func start_updating_component(cmp):
	if !self._updating_component :
		self._updating_component = {}


func get_component_name(cmp):
	for c_name in _components:
		var component = _components[c_name]
		if component == cmp :
			return c_name
	return "component"

func add_tag(tag:String):
	self.game_entity.add_to_group(tag)