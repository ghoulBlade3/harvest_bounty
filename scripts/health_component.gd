extends Node
class_name health_component

@export var kMaxHealth: float = 100.0
var health: float
var parent

func _ready():
	parent = get_parent()
	health = kMaxHealth

func damage(attack_damage, knockback_amnt, knockback_dir):
	health -= attack_damage
	parent.velocity += knockback_dir.normalized() * knockback_amnt
	parent.stunned = true
	get_tree().create_timer(1).timeout.connect(func(): parent.stunned = false)
	
	if health <= 0:
		parent.queue_free()
