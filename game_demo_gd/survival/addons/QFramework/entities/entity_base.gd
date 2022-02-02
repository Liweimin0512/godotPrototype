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

# var entity_name = null
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

var compoent_path = "res://components/"
var state_graph_path = "res://state_graphs/"

func _load_component(name):
	if _components[name] == null :
		_components[name] = load(compoent_path + name + ".gd").new()
	return _components[name]

func _load_state_graph(name):
	if _state_graphs[name] == null:
		var fn = load(state_graph_path + name + ".gd").new()
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
		# anim_state.pause()
		pass
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

	# self.restart_brain()
	if self.sg :
		self.sg.start()

	emit_signal("exit_limbo")

func on_progress():
	for c_name in _components :
		if _components[c_name].has_function("on_progress"):
			_components[c_name].on_progress()

func _to_string():
	# return String.format("%d - %s%s", self.GUID, self.prefab or "", self.inlimbo and "(LIMBO)" or "")
	pass

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

func remove_tag(tag:String):
	self.game_entity.remove_from_group(tag)

func add_component(name : String):
	if self._components[name]:
		print("component" + name + "already exists!")
	var cmp = self._load_component(name)
	assert(cmp, "component" + name + "dose not exist!")

	var loaded_cmp = cmp.construct(self)
	self._components[name] = loaded_cmp
	# var post_init_fns = ModManager.get_post_init_fns("component_post_init",name)

	# for k in post_init_fns:
	# 	fn(loaded_cmp, self)
	
func remove_component(name):
	var cmp = self._components[name]
	if cmp:
		# self._stop_updating_components(cmp)
		# self._stop_wall_updating_component(cmp)
		self._components[name] = null
		if cmp.has_function("on_remove_from_entity") :
			cmp.on_remove_from_entity()
	
# near_sighted_names = null

# var near_sighted_key_black_list = {
# 	NIL = true,
# 	DARKNESS = true,
# 	CHARLIE = true,
# 	HUNGER = true,
# 	COLD = true,
# 	HOT = true,
# 	SHENANIGANS = true,
# 	RESURRECTION_PENALTY = true,
# 	DROWNING = true,
# 	BURNT = true,
# 	UNKNOWN = true,

# 	WARBUCKS = true,
# 	DEVTOOL = true,
# }

func _test_vision_fn(k,v):
	pass

func set_entity_name(name):
	self.game_entity = name
	self.game_entity.name = name
	self.name = name

func set_entity_name_override(name_override) -> void:
	self.name_override = name_override

func spawn_entity(entity_name : String):
	pass

func spawn_child(name):
	if self.game_entity:
		assert(self.prefabs, "no prefabs registered for this entity " + name)
		var prefab = self.prefabs[name]
		assert(prefab, "Could not spawn unknown child type " + name)
		var inst = spawn_entity(name)
		assert(inst, "Could not spawn prefab " + name + " " + prefab)
		self.add_child(inst)
		return inst
	else:
		var inst = spawn_entity(name)
		self.add_child(inst)
		return inst

func remove_child_entity(child):
	child.parent = null
	if self.children :
		self.children[child] = null
	child.game_entity.set_parent(null)

func add_child_entity(child):
	if child.parent :
		child.parent.remove_child(child)
	
	child.parent = self
	if ! self.children:
		self.children = {}
	
	self.children[child] = true
	child.game_entity.set_parent(self.game_entity)

func get_brain_string():
	pass

func get_debug_string():
	pass

##### 行为树相关方法 #####

func stop_brain():
	if self.brain :
		self.brain.stop()
	self.brain = null

func set_brain(brain_fn):
	self.brain_fn = brain_fn
	if self.brain :
		self.restart_brain()

func restart_brain():
	pass

##### 状态机相关方法 ######

func set_state_graph(name):
	if self.sg :
		# SGManager.remove_instance(self.sg)
		pass
	var sg = _load_state_graph(name)
	assert(sg)

	if sg :
		# self.sg = state_graph_instance(sg, self)
		# SGManager.add_instance(self.sg)
		self.sg.go_to_state(self.sg.sg.default_state)

func clear_state_graph():
	if self.sg :
		# SGManager.remove_instance(self.sg)
		self.sg = null

##### 其他 #####

func get_position():
	return game_entity.position

func get_angle_to_point(x,y,z):
	# if not x :
	# 	return 0

	# if x and not y and not z :
	# 	y = x
	# 	z = x

	# var px, py, pz = self.game_entity.position
    # var dz = pz - z
    # var dx = x - px
    # var angle = MATH_ATAN2(dz, dx) / DEGREES
    # return angle
	pass

func force_face_point():
	pass

func force_point(x,y,z):
	pass

func get_components():
	return _components