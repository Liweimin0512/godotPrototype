extends Node
class_name DatatableManager

signal load_datatable_success
signal load_datatable_fail

var _datatable_dics : Dictionary = {}
export var _datatable_path : String = "res://datatables"

var can_async : bool = ["Windows","OSX","UWP", "X11"].has(OS.get_name())

func get_datatable(datatable_name : String) -> Dictionary:
	return {}

func load_datatable(name : String, path : String) :
	pass

func set_datatable_path(path:String) -> void:
	_datatable_path = path

