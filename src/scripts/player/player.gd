class_name Player
extends CharacterBody2D

## Movement Variables
## 
## 
## 
## 
## 

@export var speed : float = 250
@export var acceleration : float = 10
@export var friction : float = 10
@export var jump_strength : float = 50

## Timers
##
## These timers are crucial for keeping track of two platformer mechanics: Coyote Jump and Jump Buffer
##
## Coyote Jump: After the player walks off the ledge, there is a brief period where you are still able to jump.
## Jump Buffer: If the player presses jump before they hit the ground, it will still registers the jump
##
@onready var jump_buffer_timer : Timer = $JumpBufferTimer
@onready var coyote_jump_timer : Timer = $CoyoteJumpTimer

@export var jump_gravity = Vector2(0, 9.8)
@export var fall_gravity = Vector2(0, 9.8 * 1.5)

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

@onready var raycast : RayCast2D = $RayCast2D

func _physics_process(delta: float) -> void:
	#Handle sprite flipping
	var direction = Input.get_axis("left", "right")
	if direction:
		sprite.flip_h = direction < 0
		
	#If player is on floor, restart Coyote Timer
	if is_on_floor():
		coyote_jump_timer.start()
	
	#If player presses the jump button, restart the Jump Buffer Timer
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
	
	#Applying velocity and collision on player
	move_and_slide()

	
