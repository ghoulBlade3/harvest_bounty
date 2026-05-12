extends Area2D
@onready var farmland_center: Node2D = $farmland_center
@onready var farmland_sprite: Sprite2D = $farmland_sprite
@onready var farmland_plant: Sprite2D = $farmland_plant
@onready var player: CharacterBody2D = $"../../player"
@onready var farmland_selection_overlay: Sprite2D = $farmland_selection_overlay



var isWet: bool = false
var isGrown: bool = false
var isPlantedOn: bool = false


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
	if player.inventory[player.selectedItem] > 0 && isWet && not isPlantedOn:
			
			# PUT PLANT TEXTURE AND LOWER ITEM COUNT
			farmland_plant.texture = load("res://textures/blocks/" + player.items.find_key(player.selectedItem) + "_stage_0.png")
			player.inventory[player.selectedItem] -= 1
			isPlantedOn = true
				
			# UNSELECT THE ITEM IF THE PLAYER RAN OUT
			if (player.inventory[player.selectedItem] <= 0):
				player.selectedItem = player.items["empty"]
	
	# PLANTS ARE COLLECTED
	if isGrown:
		print("COLLECTING GROWN THING")
	
	print("Ok")



#func _process(delta: float) -> void:
	#var playerDistance: float = farmland_center.global_position.distance_to(player.player_center.global_position)
	#
	#
	## DO FARMLAND ACTION IF PLAYER CAN REACH IT
	#if playerDistance <= 7.9995:
		#farmland_selection_overlay.show()
		#if Input.is_action_just_pressed("interact") && player.canInteract:
			#farmland_action()
	#else:
		#farmland_selection_overlay.hide()
