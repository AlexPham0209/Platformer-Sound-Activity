class_name JumpState
extends State

@export var player : Player

func enter(param : Dictionary = {}) -> void:
	player.velocity.y = -player.jump_strength
	player.animation_player.play("jump")
	
func physics_update(delta : float) -> void:
	player.velocity += player.jump_gravity
	
	var direction = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration * delta)
	
	if Input.is_action_just_released("jump"):
		player.velocity.y /= 2
		
	if player.velocity.y > 0:
		transition_to.emit("Fall")
