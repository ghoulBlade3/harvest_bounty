extends Area2D
@onready var farmland_sprite: Sprite2D = $farmland_sprite
@onready var farmland_plant: Sprite2D = $farmland_plant
@onready var player: CharacterBody2D = $"../../player"
@onready var farmland_selection_overlay: Sprite2D = $farmland_selection_overlay
@onready var button_holder: Control = $"../../camera/button_holder"
@onready var grow_time: Timer = $grow_time
@onready var player_area: Area2D = $"../../player/player_area"
@onready var player_sprite: AnimatedSprite2D = $"../../player/player_sprite"


var isInReach: bool = false

var isWet: bool = false
var isPlantedOn: bool = false

var growthStage: int = 0
var isGrowing: bool = false
var crop = null
const kGrowTime: float = 0.2

var oldPlayerAnimation: StringName
var oldPlayerSpeed: float


func _ready() -> void:
	grow_time.wait_time = kGrowTime


func farmland_water() -> void:
	# GET CURRENT ANIMATION SO IT CAN PLAY IT AFTER WATERING IS DONE
	oldPlayerAnimation = player_sprite.animation
	
	# GET PLAYER SPEED SO PLAYER CAN BE SET AFTER WATERING IS DONE
	oldPlayerSpeed = player.speed
	
	# MAKE PLAYER UNABLE TO MOVE/ANIMATE && DISABLE THEIR INTERACTIONS
	player.canInteract = false
	player.speed = 0.0
	player_sprite.play("watering_side")

	isWet = true
	farmland_sprite.texture = load("res://textures/blocks/farmland_wet.png")
	return


func farmland_action() -> void:
	
	# PLANTS ARE PLANTED
	if player.inventory[player.selectedItem] != null:
		if player.inventory[player.selectedItem] > 0 && not isPlantedOn:
				
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
	
	# PLANTS ARE CONSUMED IF PLANT IS FULLY GROWN
	if growthStage != 2:
		return
	player.consume_food(crop)
	
	# RESET PLANT SO IT CAN BE PLANTED ON AGAIN
	isPlantedOn = false 
	growthStage = 0
	farmland_plant.texture = null
	crop = null
	return


func add_growth_stage():
	growthStage += 1
	farmland_plant.texture = load("res://textures/blocks/" + crop + "_stage_" + str(growthStage) + ".png")
	isGrowing = false


func _process(_delta: float) -> void:
	
	# IF PLANTED CROP ISNT FULLY GROWN, START GROWING
	if isPlantedOn && growthStage <= 1 && isWet:
		if !isGrowing:
			grow_time.start()
			isGrowing = true
		elif grow_time.time_left == 0:
			add_growth_stage()

	# IF PLAYER IS DONE WATERING THE FARMLAND, RETURN THEIR SPEED/ANIM BACK TO NORMAL
	if isWet:
		if not player_sprite.is_playing() && player.canInteract == false:
			player.speed = oldPlayerSpeed
			player.canInteract = true
			player_sprite.play(oldPlayerAnimation)
	
	 # STOP CODE HERE IF PLAYER CANT REACH FARMLAND
	if !isInReach:
		farmland_selection_overlay.hide()
		return
	farmland_selection_overlay.show()
	
	# PLAYER INTERACTS WITH FARMLAND
	if Input.is_action_just_pressed("interact") && player.canInteract:
		farmland_action()
	if Input.is_action_just_pressed("water") && player.canInteract && not isWet:
		farmland_water()
	return


func _on_area_entered(area: Area2D) -> void:
	# DETECT PLAYER ENTERING
	if area == player_area:
		isInReach = true
	return

func _on_area_exited(area: Area2D) -> void:
	# DETECT PLAYER LEAVING
	if area == player_area:
		isInReach = false
	return
