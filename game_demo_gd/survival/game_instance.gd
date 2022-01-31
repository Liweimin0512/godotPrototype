extends Node

# var player : Player
var game_speed = 1
var entity_manager : EntityManager

func _ready():
	entity_manager = QInstance.get_entity_manager()
	entity_manager.register_entity("player","res://entities/entity_player.gd")
	entity_manager.create_entity("player", Vector2(100,100))
