extends Button
@onready var player: CharacterBody2D = $"../../../player"
@onready var text_label: RichTextLabel = $"../carrot_text"

var plantID = null



func _ready() -> void:
	plantID = player.items[name.substr(0, name.find('_'))]
	pressed.connect(_button_pressed)

func update_text() -> void:
	text_label.text = str(player.inventory[plantID]) + "x"

func _button_pressed():
	player.inventory[plantID] += 1
	print()
	update_text()
