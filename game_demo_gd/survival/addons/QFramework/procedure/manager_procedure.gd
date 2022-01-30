# is in fact an FSM of the whole lifecycle of the game. 
# It'd be a very good habit to decouple different game states via procedures. 
# For a network game, you probably need procedures of checking resources, 
# updating resources, checking the server list, selecting a server, 
# logging in a server and creating avatars. 
# For a standalone game, you perhaps need to switch between procedures of the menu and the real gameplay. 
# The user could add procedures by simply subclassing and implementing the 'ProcedureBase' class
extends StateMachine
class_name ProcedureManager

func add_procedure(name,procedure):
	self.add_state(name, procedure)

func add_procedures(procedures:Dictionary):
	pass

func set_initial_procedure(name):
	set_initial_state(name)

func get_current_procedure() -> ProcedureBase:
	return self.current_state as ProcedureBase
