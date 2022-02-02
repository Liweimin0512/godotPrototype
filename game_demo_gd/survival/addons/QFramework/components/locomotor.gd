# 运动组件
extends ComponentBase
class_name Locomotor

const PATHFIND_PERIOD = 1
const PATHFIND_MAX_RANGE = 40

const STATUS_CALCULATING = 0
const STATUS_FOUNDPATH = 1
const STATUS_NOPATH = 2

const NO_ISLAND = 127

const ARRIVE_STEP = .15

func is_valid()->bool:
    if self.inst :
        if not self.inst.is_valid():
            return false
    return true

func _to_string():
    if self.inst :
        return "going to entity: " + String(self.inst)
    elif self.word_offset :
        return "heading to point: " + String(self.world_offset)
    else:
        return "no dest"

func get_point() -> Vector2:
    var pt = null

    if self.inst and self.inst._components.inventory_item and self.inst._components.inventory_item.owner:
        return self.inst._components.inventory_item.owner.game_entity.position
    elif self.inst :
        return self.inst.game_entity.position
    elif self.world_offset :
        return self.world_offset
    else:
        return Vector2()

