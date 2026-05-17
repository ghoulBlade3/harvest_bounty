extends Node2D
@onready var player: player = $"../../player"
@onready var health_component: health_component = $"../../player/health_component"


func _ready() -> void:
	# SET ALL STATS AT THE START OF THE GAME
	update_stat("health")
	update_stat("money")
	update_stat("kills")


func update_stat(stat: String) -> void:
	
	
	for statBar in get_children():
		if statBar.texturePath == ("res://textures/ui/" + stat + ".png"):
			
			match stat:
				"health":
					statBar.get_child(0).text = str(health_component.health)
					return
				"money":
					statBar.get_child(0).text = str(player.money)
					return
				"kills":
					statBar.get_child(0).text = str(player.kills)
	return
