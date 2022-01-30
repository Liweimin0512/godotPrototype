extends ComponentBase
class_name PlayerControllerComponent

export (int) var speed = 200
var velocity : Vector2

func _ready():
	yield(owner,"ready")
	entity = owner as KinematicBody2D
	assert(entity != null)

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
	velocity = entity.move_and_slide(velocity)
