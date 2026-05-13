extends Node2D
var entity_pos: Vector2 = Vector2.ZERO
const offset: Vector2 = Vector2(0,9)
@export var shadow_size = 5

func _onready() -> void:
	entity_pos = get_parent().global_position

func _draw() -> void:
	draw_circle(entity_pos + offset, shadow_size, Color("252c4578"))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
