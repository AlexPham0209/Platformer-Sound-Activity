extends CharacterBody2D


## Timers
##
## These timers are crucial for keeping track of two platformer mechanics: Coyote Jump and Jump Buffer
##
## Coyote Jump: After the player walks off the ledge, there is a brief period where you are still able to jump.
## Jump Buffer: If the player presses jump before they hit the ground, it will still registers the jump
##
@onready var jump_buffer_timer : Timer = $JumpBufferTimer
@onready var coyote_jump_timer : Timer = $CoyoteJumpTimer
