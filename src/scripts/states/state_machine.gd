class_name StateMachine
extends Node

var states : Dictionary
var current_state : State
@export var initial_state : State

func _ready():
	for state in get_children().filter(func(state): return state is State):
		states[state.name] = state
		state.transition_to.connect(transition_to)
		state.state_machine = self
		
	self.current_state = initial_state
	await owner.ready
	current_state.enter()

func _physics_process(delta):
	if current_state != null:
		current_state.physics_update(delta)
	
func _process(delta):
	if current_state != null:
		current_state.update(delta)
	
func _input(event):
	if current_state != null:
		current_state.input(event)
	
func transition_to(state_name : String, param : Dictionary = {}):
	if not states.has(state_name):
		return
	current_state.exit()
	current_state = states[state_name]
	current_state.enter(param)
