extends Node2D

@onready var pickup_sound : AudioStreamPlayer = $Pickup

func _on_area_2d_body_entered(body: Node2D) -> void:
	pickup_sound.play()
	queue_free()
