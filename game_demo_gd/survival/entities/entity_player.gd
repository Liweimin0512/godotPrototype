extends EntityBase


func _ready():
	pass

func create_entity(pos : Vector2):
	game_scene_path = "res://entities/Player.tscn"
	# .basefunc(args) 调用基类方法的方式
	.create_entity(pos)
