extends Node
class_name EntityBase

var game_scene_path : String = ""

func create_entity(pos : Vector2):
	var res_loader = QInstance.get_res_loader()
	var res_paths = []
	if game_scene_path == "":
		return
	res_paths.append(game_scene_path)
	var res = yield(res_loader.load_start(res_paths),"completed")
	var ins = res[0].instance()
	ins.position = pos
	self.add_child(ins)
