class_name LandState
extends State

@export var player : Player 
var dust : PackedScene = preload("res://src/scenes/particles/dust.tscn")

func enter(param : Dictionary = {}) -> void:
	player.animation_player.play("land")

	var instance : GPUParticles2D = dust.instantiate()
	instance.global_position = player.global_position + Vector2(0, 10)
	get_tree().current_scene.add_child(instance)
	
	await player.animation_player.animation_finished
	transition_to.emit("Idle" if player.velocity.x == 0 else "Run")

func physics_update(delta : float) -> void:
	var direction = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration * delta)
	
