extends Button
@onready var player: CharacterBody2D = $"../../../player"
#var plantID = player.items["carrot"]
var plantID = 0


func _ready() -> void:
	pressed.connect(_button_pressed)



func _button_pressed():
	if player.inventory[plantID] > 0:
		player.selectedItem = plantID
