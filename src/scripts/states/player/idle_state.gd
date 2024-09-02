class_name IdleState
extends State

@export var player : Player 

func enter(param : Dictionary = {}) -> void:
	player.velocity.y = 0
	player.animation_player.play("idle")
	
func physics_update(delta : float) -> void:
	#Applies friction to the player, so that they slowly go to a stop
	player.velocity.x = move_toward(player.velocity.x, 0, player.friction * delta)
	
	#If left and right keys are pressed, then transition to run state
	var direction = Input.get_axis("left", "right")
	
	if direction:
		transition_to.emit("Run")
	
	#If pressed jump key, transition to jump state
	if not player.coyote_jump_timer.is_stopped() and not player.jump_buffer_timer.is_stopped():
		transition_to.emit("Jump")
	
	#If player walked off the platform without jumping, transition to fall state
	if not player.is_on_floor():
		transition_to.emit("Fall")

func input(event : InputEvent) -> void:
	if event.is_action_pressed("down") and player.is_on_floor() and player.on_one_way_tile():
		player.global_position.y += 1
