extends Area2D
@onready var attack_animation: AnimatedSprite2D = $attack_animation
@onready var hitbox: CollisionPolygon2D = $attack_collision
@export var attack_damage: float
@export var knockback_amnt: float
var knockback_dir

func _ready():
	attack_animation.play("attack")

func _on_attack_animation_animation_finished() -> void:
	queue_free()


func _on_area_entered(area: Area2D):
	if area is enemy_hurtbox:
		var enemy = area.get_parent()
		var health: health_component = enemy.get_node("health_component")
		health.damage(attack_damage, knockback_amnt, knockback_dir)
		hitbox.queue_free()
