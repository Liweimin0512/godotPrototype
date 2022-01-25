extends Node
class_name EventComponent

export var messageEvent : Resource = null
export var triggerEvent : Resource = null

# 可以使用事件资源侦听事件
func someMethod1() -> void:
	if triggerEvent && triggerEvent is EventResource:
		triggerEvent.connect('custom_event', self, '_onTriggerEventHandler')

# 也可以使用事件资源发送事件
func someMethod2() -> void:
	var info
	if messageEvent && messageEvent is EventResource:
			messageEvent.emitSignal(info)
