# 为了保证玩家的体验，我们不推荐再使用同步的方式加载资源，
# 由于 Game Framework 自身使用了一套完整的异步加载资源体系，
# 因此只提供了异步加载资源的接口。
# 不论简单的数据表、本地化字典，
# 还是复杂的实体、场景、界面，我们都将使用异步加载。
# 同时，Game Framework 提供了默认的内存管理策略
# （当然，你也可以定义自己的内存管理策略）。
# 多数情况下，在使用 GameObject 的过程中，
# 你甚至可以不需要自行进行 Instantiate 或者是 Destroy 操作

# Initialize.
queue = preload("res://addons/QFramework/resource/resource_queue.gd").new()
queue.start()

# Suppose your game starts with a 10 second cutscene, during which the user
# can't interact with the game.
# For that time, we know they won't use the pause menu, so we can queue it
# to load during the cutscene:
queue.queue_resource("res://pause_menu.tres")
start_cutscene()

# Later, when the user presses the pause button for the first time:
pause_menu = queue.get_resource("res://pause_menu.tres").instance()
pause_menu.show()

# When you need a new scene:
queue.queue_resource("res://level_1.tscn", true)
# Use "true" as the second argument to put it at the front of the queue,
# pausing the load of any other resource.

# To check progress.
if queue.is_ready("res://level_1.tscn"):
    show_new_level(queue.get_resource("res://level_1.tscn"))
else:
    update_progress(queue.get_progress("res://level_1.tscn"))

# When the user walks away from the trigger zone in your Metroidvania game:
queue.cancel_resource("res://zone_2.tscn")