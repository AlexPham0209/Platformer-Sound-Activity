extends Camera2D

@onready var top_left : Marker2D = $TopLeft
@onready var bottom_right : Marker2D = $BottomRight

func _ready() -> void:
	limit_left = top_left.global_position.x
	limit_right = bottom_right.global_position.x
	
	limit_top = top_left.global_position.y
	limit_bottom = bottom_right.global_position.y
