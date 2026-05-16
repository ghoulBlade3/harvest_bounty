extends Sprite2D
@onready var text: RichTextLabel = $text
@onready var player: player = $"../../../player"

@export var newTexture: Texture2D
var texturePath = null

func _ready() -> void:
	texture = newTexture
	texturePath = texture.resource_path
	return
