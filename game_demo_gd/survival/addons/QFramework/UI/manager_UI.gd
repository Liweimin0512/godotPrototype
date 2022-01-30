# 提供管理界面和界面组的功能，如显示隐藏界面、激活界面、改变界面层级等。不论是 Unity 内置的 uGUI 还是其它类型的 UI 插件（如 NGUI），只要派生自 UIFormLogic 类并实现自己的界面类即可使用。界面使用结束后可以不立刻销毁，从而等待下一次重新使用
extends Node
class_name UIManager

func show_form(form_path : String) -> UIFormBase:
	var ui_instance = load(form_path).instance()
	self.add_child(ui_instance)
	return ui_instance
