extends ComponentBase
class_name InventoryComponent

const MAX_SLOTS = 15

var item_slots : Dictionary = {}
var max_slots = MAX_SLOTS
var recipes :Dictionary = {}
var recipe_count : int = 0

var equip_slots : Dictionary = {}
var drop_on_death : bool = false

var active_item = null
var accepts_stacks : bool = true
var ignore_scan_go_in_container : bool = true
var open_containers : Dictionary = {}

func _ready():
    ._ready()
    owner.connect("death",self,"on_owner_death")

func on_owner_death():
    if !self.drop_on_death:
        return
    if self.active_item :
        self.drop_item(self.active_item)
        self.set_active_item(null)
    for k in range(1, self.max_slots):
        var v = self.item_slots[k]
        if v :
            self.drop_item(v, true, true)
    if ! keep_equip:
        for s in equip_slots:
            if !on_death or ! equip_slots[s].get_component("inventory_item").keep_on_death :
                self.drop_item(v, true, true)

func NumItems() -> int:
    var num = 0
    for d in self.item_slots :
        num = num + 1
    return num

