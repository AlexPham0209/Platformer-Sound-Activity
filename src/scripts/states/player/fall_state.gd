class_name FallState
extends State

@export var player : Player
var max_fall : float

func enter(param : Dictionary = {}) -> void:
	player.animation_player.play("fall")
	max_fall = 0
	
func physics_update(delta : float) -> void:
	player.velocity += player.fall_gravity
	max_fall = max(max_fall, player.velocity.y)
	
	var direction = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration * delta)
	
	if not player.coyote_jump_timer.is_stopped() and Input.is_action_just_pressed("jump"):
		transition_to.emit("Jump")
		
	elif player.is_on_floor():
		if max_fall >= player.landing_velocity:
			transition_to.emit("Land")
		else: 
			transition_to.emit("Idle" if player.velocity.x == 0 else "Run")
