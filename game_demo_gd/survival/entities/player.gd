extends EntityBase

var AnimationPlayer
var AnimationTree

func _ready():
	pass
	
func create_entity(pos : Vector2):
	game_scene_path = "res://entities/Player.tscn"
	print("create_player_entity")
	# .basefunc(args) 调用基类方法的方式
	.create_entity(pos)

func on_create_prafab_completed():
	AnimationTree = game_prefab.get_node("AnimationTree")
	print(AnimationTree.name)
