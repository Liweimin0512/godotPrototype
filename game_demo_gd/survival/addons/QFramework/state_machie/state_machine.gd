# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
var initial_state 
# The current active state. At the start of the game, we get the `initial_state`.
var current_state: StateBase
var states = {}

# func _ready() -> void:
# 	# yield(owner, "ready")
# 	# The state machine assigns itself to the State objects' state_machine property.
# 	for child in get_children():
# 		states[child.name] = child
# 		child.state_machine = self
# 	# state.enter()
func add_state(name,state) -> void:
	var s = state.new()
	self.add_child(s)
	states[name] = s

func set_initial_state(name) -> void:
	initial_state = states[name]

func launch() -> void:
	# 需要手动启动状态机
	current_state = initial_state
	for child in get_children():
		child.state_machine = self
	current_state.enter()

# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	if !current_state:
		return
	current_state.handle_input(event)


func _process(delta: float) -> void:
	if !current_state:
		return
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	if !current_state:
		return
	current_state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not states.has(target_state_name):
		return
	if !current_state:
		return
	current_state.exit()
	current_state = states[target_state_name]
	current_state.enter(msg)
	emit_signal("transitioned", target_state_name)
