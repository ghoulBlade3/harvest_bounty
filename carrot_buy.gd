extends Button
@onready var player: CharacterBody2D = $"../../../player"
@onready var carrot_font: RichTextLabel = $"../carrot_font"




func _ready() -> void:
	pressed.connect(_button_pressed)



func _button_pressed():
	player.inventory[0] += 1
	
	print(player.inventory[0])
