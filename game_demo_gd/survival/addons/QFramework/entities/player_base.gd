extends EntityBase
class_name PlayerBase

func make_palyer_character(name, custom_prefabs, custom_assets, custom_fn, starting_inventory):
    
    self.add_tag("player")
    var inst = create_entity(Vector2(0,0))
    inst.set_can_sleep(false)

    var trans = inst.game_prefab.transform

    self.add_tag("player")
    self.add_tag("scary_toprey")
    self.add_tag("character")

    # locomotor must be constructed before the stategraph
    var locomotor = self.add_component("locomotor")
    locomotor.set_slow_multiplier(0.6)
    locomotor.pathcaps = {
        "player" : true ,
        "ignore_creep" : true
    }
    # 'player' cap not actually used, just useful for testing
    locomotor.faster_on_road = true