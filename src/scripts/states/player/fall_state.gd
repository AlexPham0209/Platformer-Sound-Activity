class_name FallState
extends State

@export var player : Player
var max_fall : float

func enter(param : Dictionary = {}) -> void:
	player.animation_player.play("fall")
	max_fall = 0
	
func physics_update(delta : float) -> void:
	#Gravity while falling if greater than when jumping
	player.velocity += player.fall_gravity
	
	#Get the maximum vertical velocity that the player had while falling
	max_fall = max(max_fall, player.velocity.y)
	
	#Apply horizontal movement 
	var direction = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration * delta)
	
	#Even though player is in falling state, if player jumps again during the coyote time period
	#Then we jump again even if the player is not grounded
	#if not player.coyote_jump_timer.is_stopped() and Input.is_action_just_pressed("jump"):
		#transition_to.emit("Jump")
	
	#If the player hits the floor, depending on how fast he was falling
	#Transition to different states, one where it generates smoke, another one where its just idle/run
	if player.is_on_floor():
		if max_fall >= player.landing_velocity:
			transition_to.emit("Land")
		else: 
			transition_to.emit("Idle" if player.velocity.x == 0 else "Run")
