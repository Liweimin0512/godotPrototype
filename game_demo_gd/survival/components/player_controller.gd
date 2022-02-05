extends ComponentBase
class_name PlayerController

var velocity : Vector2
export (int) var speed = 200
export (int) var max_speed = 500

signal character_moving

func _enter_tree():
	yield(owner,"tree_entered")
	._enter_tree()
	owner_prefab as KinematicBody2D
	assert(owner_prefab != null)

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

	if velocity != Vector2.ZERO:
		self.emit_signal("character_moving",velocity)
	owner_prefab.AnimationTree.set("parameters/idle&walk&run/blend_position",velocity.length()/max_speed)
#		owner_prefab.AnimationTree.set("parameters/idle/blend_position",velocity)
#		owner_prefab.AnimationState.travel("walk")
#	else:
#		owner_prefab.AnimationState.travel("idle")

func _process(delta):
	get_input()
	velocity = owner_prefab.move_and_slide(velocity)
