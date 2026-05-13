extends Area2D
@onready var farmland_center: Node2D = $farmland_center
@onready var farmland_sprite: Sprite2D = $farmland_sprite
@onready var farmland_plant: Sprite2D = $farmland_plant
@onready var player: CharacterBody2D = $"../../player"
@onready var farmland_selection_overlay: Sprite2D = $farmland_selection_overlay
@onready var button_holder: Control = $"../../camera/button_holder"
@onready var grow_time: Timer = $grow_time


var isWet: bool = false
var isGrown: bool = false
var isPlantedOn: bool = false

var growthStage: int = -1
var isGrowing: bool = false
var crop = null
const kGrowTime: float = 0.2



func _ready() -> void:
	grow_time.wait_time = kGrowTime


func farmland_action() -> void:
	# WATER THE FARMLAND IF ITS DRY
	if not isWet:
		print('Farmland is getting wet')
		player.canInteract = false
		isWet = true
		farmland_sprite.texture = load("res://textures/blocks/farmland_wet.png")
		player.canInteract = true
		return
	
	# PLANTS ARE PLANTED
	if player.inventory[player.selectedItem] != null:
		if player.inventory[player.selectedItem] > 0 && isWet && not isPlantedOn:
				
				# PUT PLANT TEXTURE AND LOWER ITEM COUNT
				crop = player.items.find_key(player.selectedItem)
				farmland_plant.texture = load("res://textures/blocks/" + crop + "_stage_0.png")
				player.inventory[player.selectedItem] -= 1
				for button in button_holder.get_children():
					button.update_text()
					
				# UNSELECT THE ITEM IF THE PLAYER RAN OUT
				if (player.inventory[player.selectedItem] <= 0):
					player.selectedItem = player.items["empty"]
				
				isPlantedOn = true
				growthStage += 1
	
	# PLANTS ARE COLLECTED
	if isGrown:
		print("COLLECTING GROWN THING")
	
	print("Ok")



func add_growth_stage():
	growthStage += 1
	farmland_plant.texture = load("res://textures/blocks/" + crop + "_stage_" + str(growthStage) + ".png")
	isGrowing = false


func _process(delta: float) -> void:
	
	
	# IF PLANTED CROP ISNT FULLY GROWN, START GROWING
	if isPlantedOn && growthStage <= 1:
		if !isGrowing:
			grow_time.start()
			isGrowing = true
		elif grow_time.time_left == 0:
			add_growth_stage()

	# TODO: move this to player
	var playerDistance: float = farmland_center.global_position.distance_to(player.player_center.global_position)
	
	# DO FARMLAND ACTION IF PLAYER CAN REACH IT
	if playerDistance <= 7.9995:
		farmland_selection_overlay.show()
		if Input.is_action_just_pressed("interact") && player.canInteract:
			farmland_action()
	else:
		farmland_selection_overlay.hide()
