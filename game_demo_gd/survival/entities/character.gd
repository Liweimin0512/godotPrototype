extends EntityBase

onready var AnimationPlayer = $AnimationTree
onready var AnimationTree = $AnimationTree
onready var AnimationState = AnimationTree.get("parameters/playback")
