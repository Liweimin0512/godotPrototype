extends Node

# var player : Player
#var game_speed = 1
#var entity_manager : EntityManager

var player_character
var player_controller

func _ready():
	player_character = EntityManager.create_entity("player",Vector2(100,100))
	player_controller = load("res://game_play/player_controller.gd").new()
	self.add_child(player_controller)
	print("game_instance")
