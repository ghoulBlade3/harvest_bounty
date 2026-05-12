extends Button
@onready var player: CharacterBody2D = $"../../../player"

var plantID = null


func _ready() -> void:
	pressed.connect(_button_pressed)



func _button_pressed():
	if player.inventory[plantID] > 0:
		player.selectedItem = plantID
