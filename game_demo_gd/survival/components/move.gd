extends ComponentBase
class_name Move

var velocity : Vector2 = Vector2.ZERO
export (int) var speed := 240
export (int) var max_speed = 500

var _dir := Vector2()

signal character_moving

func _enter_tree():
	yield(owner,"tree_entered")
	._enter_tree()
	owner_prefab as KinematicBody2D
	assert(owner_prefab != null)

#func get_input():
#	velocity = Vector2()
#	if Input.is_action_pressed("ui_right"):
#		velocity.x += 1
#	if Input.is_action_pressed('ui_left'):
#		velocity.x -= 1
#	if Input.is_action_pressed('ui_down'):
#		velocity.y += 1
#	if Input.is_action_pressed('ui_up'):
#		velocity.y -= 1
#
#	velocity = velocity.normalized() * speed	
	
func _physics_process(delta):
	var motion = self._dir * self.speed
	if motion != Vector2.ZERO:
		owner_prefab.move_and_slide(motion)
		self.emit_signal("character_moving",motion)
		print(motion.length())
	owner_prefab.animation_tree.set("parameters/idle&walk&run/blend_position",motion.length()/max_speed)

func move_to_target(target : Vector2):
	if owner_prefab:
		self._dir = (target - owner_prefab.position).normalized()
