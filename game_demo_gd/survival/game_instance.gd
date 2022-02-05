extends Node

# var player : Player
#var game_speed = 1
#var entity_manager : EntityManager

var _player_character : KinematicBody2D

func _ready():
	EntityManager.create_entity("character_master",Vector2(100,100))
	EntityManager.connect("create_entity_completed",self,"on_create_entity_completed")

func on_create_entity_completed(entity):
	_player_character = entity
	# player_character.get_node("ComponetManager").add_component("player_controller")

func get_player_character():
	yield(EntityManager,"create_entity_completed")
	if _player_character:
		return _player_character
		
