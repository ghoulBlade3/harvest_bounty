extends Node
class_name dir_anim_compoment

var sprite: AnimatedSprite2D
var lastLookDir: String = "S"

func dir_animation(sprite, moveDir):
	if moveDir.x < 0:
		lastLookDir = "S"
		sprite.flip_h = true
		sprite.play("walk_cycle_side")
		lastLookDir = 'A'
	elif moveDir.x > 0:
		sprite.flip_h = false
		sprite.play("walk_cycle_side")
		lastLookDir = 'D'
	elif moveDir.y > 0:
		sprite.play("walk_cycle_front")
		lastLookDir = 'S'
	elif moveDir.y < 0:
		sprite.play("walk_cycle_back")
		lastLookDir = 'W'


	# SET SPRITES WHEN STANDING STILL
	if moveDir == Vector2.ZERO:
		match lastLookDir:
			'W':
				sprite.play("standing_back")
			'A':
				sprite.play("standing_side")
				sprite.flip_h = true
			'S':
				sprite.play('standing_front')
			'D':
				sprite.play("standing_side")
				sprite.flip_h = false
	pass
