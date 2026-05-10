extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $player_sprite
@onready var player_center: Node2D = $player_center
@onready var carrot_font: RichTextLabel = $"../camera/Control/carrot_font"


const kSpeed: float = 4800.0
var health: int = 5
var canInteract: bool = true

var selectedItem = -1
var inventory: Array[int] = [0, 0]



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


	# UPDATE LABELS
	carrot_font.text = str(inventory[0])
	print(inventory[0])
