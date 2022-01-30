extends Node
class_name TimeManager

var world_time : float = 0
const hour_second = 15
const one_day_hour = 24

# Called when the node enters the scene tree for the first time.
func _ready():
	GameInstance.time_manager = self

func _physics_process(delta):
	world_time += delta * GameInstance.game_speed
#	print(world_time,"天数：", get_day(),"小时：",get_hour())

func get_day() -> int:
	return int(world_time / (one_day_hour*hour_second))

func get_hour() -> int:
	var day = get_day()
	return int((day * one_day_hour - world_time/hour_second) * -1)
