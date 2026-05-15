extends CharacterBody2D

@onready var player: player1 = $"../player"
var last_velocity_normalized = Vector2.ZERO
@onready var sprite: AnimatedSprite2D = $enemy_bounty_hunter_sprite
@onready var directional_animation_component: dir_anim_compoment = $directional_animation_component


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 2400 * delta 
	
	directional_animation_component.dir_animation(sprite, direction)
	
	## JITTER FIX
	#if velocity.normalized() != last_velocity_normalized:
		#position.x = round(position.x)
		#position.y = round(position.y)
	#last_velocity_normalized = velocity.normalized()
	move_and_slide()
