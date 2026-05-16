extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(get_parent().costs[get_parent().kPlantName]) + " c"
	return
