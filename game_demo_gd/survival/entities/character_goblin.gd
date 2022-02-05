extends KinematicBody2D

onready var move_component = $ComponetManager/Move
onready var component_manager = $ComponetManager
onready var sprite : Sprite = $Sprite
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	print("goblin ready")
	yield(EntityManager,"create_entity_completed")
	self.component_manager.set_owner_prefab(self)
	var target = Vector2(200,200)
	move_component.move_to_target(target)
	move_component.connect("character_moving",self,"_on_character_moving")

func _on_character_moving(motion):
	var max_speed = move_component.max_speed
	if motion.x <= 0 :
		sprite.flip_h = true
	elif motion.x > 0 :
		sprite.flip_h = false
	animation_tree.set("parameters/idle&walk&run/blend_position",motion.length()/max_speed)
