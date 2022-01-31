# 提供场景管理的功能，可以同时加载多个场景，也可以随时卸载任何一个场景，从而很容易地实现场景的分部加载
extends Node
class_name SceneManager

var current_scene = null

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	
	#这个函数通常会从一个信号回调、
	#或当前场景中的其他函数中调用。此时删除当前场景不是一个好主意，
	#因为它可能仍在执行代码。这将导致崩溃或意外行为。
	#解决方案是将加载延迟到稍后的时间，此时我们可以确保当前场景中没有代码在运行
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	#现在可以安全地移除当前场景了
	current_scene.free()

	# Load the new scene.
	#加载新场景。
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	#实例化新场景。
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	#将它添加到活动场景中，作为根的子级。
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	#（可选）使其与SceneTree.change_scene（）API兼容。
	get_tree().set_current_scene(current_scene)
