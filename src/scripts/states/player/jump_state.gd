class_name JumpState
extends State

@export var player : Player

#On enter, we set the current vertical velocity to -jump_strength
func enter(param : Dictionary = {}) -> void:
	player.velocity.y = -player.jump_strength
	player.animation_player.play("jump")

func physics_update(delta : float) -> void:
	#Gravity while jumping is less than while falling
	player.velocity += player.jump_gravity
	
	#Horizontal movement
	var direction = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration * delta)
	
	#If you release the jump button, it halves the current velocity, meaning the player reaches its jump peak lower and faster
	#This allows variable jump heights depending on how long you hold the jump button
	if Input.is_action_just_released("jump"):
		player.velocity.y /= 2
	
	#If vertical velocity is less than 0, that means we are falling
	#Because we are falling, we are transitioning to the falling state
	if player.velocity.y > 0:
		transition_to.emit("Fall")
