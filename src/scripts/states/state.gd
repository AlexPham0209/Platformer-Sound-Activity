class_name State
extends Node

signal transition_to(state_name : String, param : Dictionary)
var state_machine : StateMachine

func enter(param : Dictionary = {}) -> void:
	pass
	
func exit() -> void:
	pass

func update(delta : float) -> void:
	pass
	
func physics_update(delta : float) -> void:
	pass
	
func input(event) -> void:
	pass
