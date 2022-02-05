extends EntityBase

onready var AnimationPlayer = $AnimationTree
onready var AnimationTree = $AnimationTree
onready var AnimationState = AnimationTree.get("parameters/playback")
onready var player_controller = $ComponetManager/PlayerController

onready var s_body = $sprite_body
onready var s_hair = $sprite_hair
onready var s_tool = $sprite_tool

func _ready():
	player_controller.connect("character_moving",self,"_on_character_moving")

func _on_character_moving(velocity):
	if velocity.x > 0:
		s_body.flip_h = false
		s_hair.flip_h = false
		s_tool.flip_h = false
	elif velocity.x < 0:
		s_body.flip_h = true
		s_hair.flip_h = true
		s_tool.flip_h = true
