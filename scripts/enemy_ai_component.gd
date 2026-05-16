extends Node
class_name enemy_ai_component

@onready var target: CharacterBody2D = $"../../player"
@onready var parent = get_parent()

@export var dir_animation_player: dir_anim_compoment
@export var kSpeed: float = 2400.0

# move enemy to player and play animation based on direction
func _physics_process(delta) -> void:
	if parent.stunned:
		get_tree().create_timer(0.3).timeout.connect(func(): parent.stunned = false)
	else:
		var direction = parent.global_position.direction_to(target.global_position)
		
		parent.velocity = direction * kSpeed * delta
		dir_animation_player.dir_animation(direction.round())
		parent.move_and_slide()
