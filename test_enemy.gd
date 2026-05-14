extends CharacterBody2D
@onready var pathfinding_component: pathfinding_component = $"pathfinding-component"
var last_velocity_normalized = Vector2.ZERO

func _process(delta):
	velocity = pathfinding_component.pathfind(global_position, delta)
	
	#if velocity.normalized() != last_velocity_normalized:
		#position.x = round(position.x)
		#position.y = round(position.y)

	#last_velocity_normalized = velocity.normalized()

	move_and_slide()
	pass
