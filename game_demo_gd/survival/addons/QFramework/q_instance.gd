extends Node

const datatable_manager_class = preload("res://addons/QFramework/datatable/csv_datatable_manager.gd")
const procedure_manager_class = preload("res://addons/QFramework/procedure/manager_procedure.gd")
const scene_manager_class = preload("res://addons/QFramework/manager_scene.gd")
const UI_manager_class = preload("res://addons/QFramework/UI/manager_UI.gd")
var _datatable_manager : DatatableManager
var _procedure_manager : ProcedureManager
var _scene_manager : SceneManager
var _UI_manager : UIManager
var config = ConfigFile.new()

func get_datatable_manager() -> DatatableManager:
	if !_datatable_manager:
		_datatable_manager = datatable_manager_class.new()
		self.add_child(_datatable_manager)
	return _datatable_manager

func get_procedure_manager() -> ProcedureManager:
	if !_procedure_manager:
		_procedure_manager = procedure_manager_class.new()
		self.add_child(_procedure_manager)
	return _procedure_manager

func get_scene_manager() -> SceneManager:
	if !_scene_manager:
		_scene_manager = scene_manager_class.new()
		self.add_child(_scene_manager)
	return _scene_manager

func get_UI_manager() -> UIManager:
	if !_UI_manager:
		_UI_manager = UI_manager_class.new()
		self.add_child(_UI_manager)
	return _UI_manager
