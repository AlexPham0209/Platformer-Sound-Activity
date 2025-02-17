class_name LandState
extends State

@export var player : Player 
@export var landing_sound : AudioStreamPlayer
var dust : PackedScene = preload("res://src/scenes/particles/dust.tscn")

func enter(param : Dictionary = {}) -> void:
	player.animation_player.play("land")
	
	if landing_sound != null:
		landing_sound.play()
		
	#Spawns dust at current location of the player
	var instance : GPUParticles2D = dust.instantiate()
	instance.global_position = player.global_position + Vector2(0, 10)
	get_tree().current_scene.add_child(instance)
	
	#Wait until the land animation is finished before transitioning to either idle or run
	await player.animation_player.animation_finished
	transition_to.emit("Idle" if player.velocity.x == 0 else "Run")

func physics_update(delta : float) -> void:
	#Horizontal movement
	var direction = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration * delta)
	
	#If pressed jump key, transition to jump state
	if not player.coyote_jump_timer.is_stopped() and not player.jump_buffer_timer.is_stopped():
		transition_to.emit("Jump")
	
	#If player walked off the platform without jumping, transition to fall state
	if not player.is_on_floor():
		transition_to.emit("Fall")

func input(event : InputEvent) -> void:
	if event.is_action_pressed("down") and player.on_one_way_tile():
		player.global_position.y += 1

func exit() -> void:
	player.animation_player.stop()
