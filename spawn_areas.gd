extends Node2D
var spawn: bool = true
var spawn_amnt: int = 1
var rng = RandomNumberGenerator.new()
const ENEMY_BOUNTY_HUNTER = preload("uid://bj63vcd61rta6")
const ENEMY_BEE = preload("uid://btentsv82auxc")
var children
@onready var timer: Timer = $Timer

func spawn_bounty_hunter(position):
	var instance = ENEMY_BOUNTY_HUNTER.instantiate()
	instance.global_position = position
	add_child(instance)
	pass
	
func spawn_bee(position):
	var instance = ENEMY_BEE.instantiate()
	instance.global_position = position
	add_child(instance)

func _ready() -> void:
	children = get_children()

func _physics_process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	for _x in spawn_amnt:
		var position: Vector2
		var rand_enemy_type: int
		var child = children[rng.randi_range(0,3)]
		position.x = rng.randi_range(child.get_child(0).global_position.x,child.get_child(1).global_position.x)
		position.y = rng.randi_range(child.get_child(0).global_position.y,child.get_child(1).global_position.y)
		rand_enemy_type = rng.randi_range(0,3)
		if rand_enemy_type > 1:
			spawn_bee(position)
		else:
			spawn_bounty_hunter(position)
