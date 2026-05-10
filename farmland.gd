extends Area2D
@onready var farmland_center: Node2D = $farmland_center
@onready var farmland_sprite: Sprite2D = $farmland_sprite
@onready var player: CharacterBody2D = $"../../player"


var isWet: bool = false


func farmland_action() -> void:
	# WATER THE FARMLAND IF ITS DRY
	if not isWet:
		print('Farmland is getting wet')
		player.canInteract = false
		isWet = true
		farmland_sprite.texture = load("res://textures/blocks/farmland_wet.png")
		player.interactableObjects.clear()
		return
	
	print("Ok")



func _process(delta: float) -> void:
	var playerDistance: float = farmland_center.global_position.distance_to(player.player_center.global_position)
	
	
	# DO FARMLAND ACTION IF PLAYER CAN REACH IT
	if Input.is_action_just_pressed("interact") && player.canInteract && playerDistance <= 32.0:
		player.interactableObjects.append(playerDistance)
		
		
		if playerDistance <= player.interactableObjects.min():
			farmland_action()
