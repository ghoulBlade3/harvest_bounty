extends Node
class_name attack_component

@onready var hurtbox: enemy_hurtbox = $"../hurtbox"
@export var attack_damage: float
@export var knockback_amnt: float
var parent

func _ready():
	hurtbox.area_entered.connect(on_area_entered)
	parent = get_parent()

func on_area_entered(area: Area2D):
	if area is player_hurtbox:
		print("enemy colliding with player")
		var enemy = area.get_parent()
		var knockback_dir = get_parent().global_position.direction_to(enemy.global_position)
		var health: health_component = enemy.get_node("health_component")
		
		health.damage(attack_damage, knockback_amnt, knockback_dir)
		parent.stunned = true
