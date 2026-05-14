extends Node
class_name pathfinding_component

@export var target: CharacterBody2D
@export var speed: float = 4800.0
var direction: Vector2

func pathfind(parent_direction, delta):
	direction = parent_direction.direction_to(target.global_position)
	return direction.normalized() * speed * delta
	
	
