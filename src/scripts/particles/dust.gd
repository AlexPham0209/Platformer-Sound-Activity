extends GPUParticles2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _on_timer_timeout() -> void:
	emitting = false
	animation_player.play("fade")
