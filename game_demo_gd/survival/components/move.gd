extends ComponentBase
class_name Move

var velocity : Vector2 = Vector2.ZERO
export (int) var speed := 240
export (int) var max_speed = 500

var _dir := Vector2()
var _target := Vector2()

signal character_moving

func _enter_tree():
	yield(owner,"tree_entered")
	._enter_tree()
	owner_prefab as KinematicBody2D
	assert(owner_prefab != null)

func _physics_process(_delta):
	self._move()

func move_to_target(target : Vector2):
	if owner_prefab:
		self._target = target

func _move():
	# print(abs(self._target.length() - owner_prefab.position.length()))
	if abs(self._target.length() - owner_prefab.position.length()) <= 1 :
		self.emit_signal("character_moving",Vector2.ZERO)
		return
	self._dir = (self._target - owner_prefab.position).normalized()
	var motion = self._dir * self.speed
	owner_prefab.move_and_slide(motion)
	self.emit_signal("character_moving",motion)
	# print(motion.length())