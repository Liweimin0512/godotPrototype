extends ComponentBase
class_name Move

var velocity : Vector2 = Vector2.ZERO
export (int) var speed = 200

func _enter_tree():
	yield(owner,"tree_entered")
	._enter_tree()
	owner_prefab as KinematicBody2D
	assert(owner_prefab != null)

func get_input():
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1

func _process(delta):
    velocity = velocity.normalized() * speed

	if velocity != Vector2.ZERO:
		owner_prefab.AnimationTree.set("parameters/walk/blend_position",velocity)
		owner_prefab.AnimationTree.set("parameters/idle/blend_position",velocity)
		owner_prefab.AnimationState.travel("walk")
	else:
		owner_prefab.AnimationState.travel("idle")

	velocity = owner_prefab.move_and_slide(velocity)

