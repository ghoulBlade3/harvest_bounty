extends Control

@onready var buy: Button = $buy
@onready var select: Button = $select
@onready var buttons: Control = $"."
@onready var text: RichTextLabel = $text
@onready var player: CharacterBody2D = $"../../../player"
@onready var icon: Sprite2D = $icon
@export var kPlantName: String = ""

var plantID = null


func _ready() -> void:
	plantID = player.items[kPlantName]
	icon.texture = load("res://textures/ui/icon_" + kPlantName + ".png")
	buy.pressed.connect(buy_function)
	select.pressed.connect(select_function)


func update_text():
	text.text = str(player.inventory[plantID]) + 'x'

# PLAYER BUYS THING IF THEY HAVE MONEY
func buy_function():
	player.inventory[plantID] += 1
	update_text()

# THING GETS SELECTED
func select_function():
	if player.inventory[plantID] > 0:
		player.selectedItem = plantID
