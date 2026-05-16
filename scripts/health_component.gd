extends Node
class_name health_component

@export var kMaxHealth: float = 100.0
var health: float
var parent
var children
var sprite

func _ready():
	parent = get_parent()
	children = parent.get_children()
	for child in children:
		if child is AnimatedSprite2D:
			print("yes")
			sprite = child
	health = kMaxHealth

func damage(attack_damage, knockback_amnt, knockback_dir):
	health -= attack_damage
	sprite.self_modulate = Color("ff0000ff")
	get_tree().create_timer(0.2).timeout.connect(func(): sprite.self_modulate = Color("ffffffff"))
	knockback_dir = knockback_dir.normalized() * knockback_amnt
	knockback_dir = knockback_dir.lerp(Vector2.ZERO, 0.5)
	parent.velocity = knockback_dir
	parent.move_and_slide()
	parent.stunned = true
	
	if health <= 0:
		if parent is player:
			get_tree().reload_current_scene()
		parent.queue_free()
		
