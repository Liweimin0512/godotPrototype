extends Node

var velocity : Vector2
export (int) var speed = 200
var player_prefab

func _ready():
	yield(get_parent(),"ready")
	print("controller")
	player_prefab = GameInstance.player_character.game_prefab as KinematicBody2D
	assert(player_prefab != null)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _process(delta):
	get_input()
	velocity = player_prefab.move_and_slide(velocity)
