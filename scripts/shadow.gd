extends Node2D
var entity_pos: Vector2 = Vector2.ZERO
const offset: Vector2 = Vector2(0,9)
@export var shadow_size = 5

# get the position of parent node
func _onready() -> void:
	entity_pos = get_parent().global_position

# draw a circle on the position of parent + an offset
func _draw() -> void:
	draw_circle(entity_pos + offset, shadow_size, Color("252c4578"))
	pass

# redraw the circle every physics frame
func _physics_process(delta: float) -> void:
	queue_redraw()
