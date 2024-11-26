class_name DeathState
extends State

@export var death_sound : AudioStreamPlayer

func _ready() -> void:
	if death_sound:
		death_sound.play()
