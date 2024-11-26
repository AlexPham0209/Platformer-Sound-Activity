class_name RunState
extends State

@export var player : Player
@export var running_sound : AudioStreamPlayer

func enter(param : Dictionary = {}) -> void:
	player.animation_player.play("run")
	if running_sound != null:
		running_sound.play()
	
func physics_update(delta : float) -> void: 
	var direction : float = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration * delta)
	
	#If player is currently pressing left and right keys, move character, else transition to idle
	if not direction:
		transition_to.emit("Idle")

	#If both jump timers are not stopped, then transition to the jump state
	if not player.coyote_jump_timer.is_stopped() and not player.jump_buffer_timer.is_stopped():
		transition_to.emit("Jump")
		
	#If player walked off the platform without jumping, transition to fall state
	elif player.coyote_jump_timer.is_stopped():
		transition_to.emit("Fall")

func input(event : InputEvent) -> void:
	if event.is_action_pressed("down") and player.on_one_way_tile():
		player.global_position.y += 1
