extends Button
@onready var player: CharacterBody2D = $"../../../player"
@onready var carrot_text: RichTextLabel = $"../carrot_text"
var plantID: int = player.items["carrot"]
#var plantID = 0



func _ready() -> void:
	pressed.connect(_button_pressed)



func _button_pressed():
	player.inventory[plantID] += 1
	carrot_text.text = str(player.inventory[plantID]) + "x"
	print(player.inventory[plantID])
