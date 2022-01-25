# 自定义资源
extends Resource
class_name EventResource # , 'res://EventResource/event_icon.svg'
# 自定义信号
signal custom_event(type, message)
# 可以定义一些属性
export var type := 'defaultEvent'
# 自定义方法用于发送信号的包装，也可以直接发送信号
func emitSignal(object) -> void:
    self.emit_signal('custom_event', type, object)