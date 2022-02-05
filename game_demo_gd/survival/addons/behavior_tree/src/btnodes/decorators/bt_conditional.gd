class_name BTConditional, "res://addons/behavior_tree/icons/btconditional.png"
extends BTDecorator

# 用来创造条件。在 tick() 之前，先检查情况，
# 如果满足条件，则执行子节点。
# 然后，条件返回与子节点相同的状态，如下所示：
# 一个普通的装饰师，而不是条件的结果。
# 如果你想知道条件的结果，把它存储在黑板上
# 在_pre_tick（）期间。

export(bool) var reverse: bool = false

var verified: bool = false
var ignore_reverse: bool = false



func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	verified = true


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if reverse and not ignore_reverse:
		verified = not verified
	
	if verified:
		return ._tick(agent, blackboard)
	return fail()


func _post_tick(agent: Node, blackboard: Blackboard, result: bool) -> void:
	pass
