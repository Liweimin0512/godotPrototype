extends Node
class_name ResourceAsyncLoader

signal done

var thread := Thread.new()
var can_async : bool = ["Windows","OSX","UWP", "X11"].has(OS.get_name())
var list := []

func load_start(resource_list : Array) -> Array:
	var resource_in = resource_list.duplicate()
	var out := []
	if can_async:
		thread.start(self, 'threaded_load', resource_in)
		out = yield(self, "done")
		thread.wait_to_finish()
	else:
		out = regular_load(resource_in)
	return out
	
func regular_load(resource_in : Array) -> Array:
	var resources_out := []
	for res_in in resource_in:
		resources_out.append(load(res_in).instance())
	return resources_out
		
func threaded_load(resources_in : Array) -> void:
	var resources_out = []
	for res_in in resources_in:
		resources_out.append(load(res_in).instance())
	call_deferred('emit_signal', 'done', resources_out)
