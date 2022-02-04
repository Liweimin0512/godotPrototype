extends Node

# var player : Player
#var game_speed = 1
#var entity_manager : EntityManager

var player_character

func _ready():
#	EntityManager.create_entity("character",Vector2(100,100))
	EntityManager.connect("create_entity_completed",self,"on_create_entity_completed")

func on_create_entity_completed(entity : Node):
	player_character = entity
#	player_character.get_node("ComponetManager").add_component("player_controller")
