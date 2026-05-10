extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $player_sprite
@onready var player_center: Node2D = $player_center


const kSpeed: float = 6400.0
var health: int = 5
var canInteract: bool = true
var interactableObjects: Array[float] = []

func _ready():
	player_sprite.play()


func _physics_process(delta: float) -> void:
	# PLAYER MOVEMENT
	var pMoveDir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = pMoveDir * kSpeed * delta;
	if pMoveDir:
		player_sprite.play("walk_cycle")
	else:
		player_sprite.play("standing_still")
	move_and_slide()
	global_position = round(global_position)
