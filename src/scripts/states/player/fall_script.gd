extends State

@export var player : Player

func enter(param : Dictionary = {}) -> void:
	player.animation_player.play("fall")
	
func physics_update(delta : float) -> void:
	var direction = Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.speed * direction, player.acceleration)
	
	if player.is_on_floor():
		transition_to.emit("Idle" if player.velocity.x == 0 else "Run")
