extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $player_sprite
@onready var player_center: Node2D = $player_center
@onready var carrot_font: RichTextLabel = $"../camera/Control/carrot_font"


const kSpeed: float = 4800.0
var health: int = 5
var canInteract: bool = true

var selectedItem = -1
var inventory: Array[int] = [0, 0]
var lastLookDir: String = 'S'



func _ready():
	player_sprite.play()

func _physics_process(delta: float) -> void:
	# PLAYER MOVEMENT
	var pMoveDir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	pMoveDir = pMoveDir.normalized()
	pMoveDir = pMoveDir * kSpeed * delta

	#velocity = pMoveDir * kSpeed * delta;
	velocity = pMoveDir

		

	if pMoveDir.x < 0:
		player_sprite.flip_h = true
		player_sprite.play("walk_sideways")
		lastLookDir = 'A'

	elif pMoveDir.x > 0:
		player_sprite.flip_h = false
		player_sprite.play("walk_sideways")
		lastLookDir = 'D'

	elif pMoveDir.y > 0:
		player_sprite.play("walk_cycle_front")
		lastLookDir = 'S'

	elif pMoveDir.y < 0:
		player_sprite.play("walk_cycle_back")
		lastLookDir = 'W'


	
	if pMoveDir == Vector2.ZERO:
		match lastLookDir:
			'W':
				player_sprite.play("standing_back")
			'A':
				player_sprite.play("standing_side")
				player_sprite.flip_h = true
			'S':
				player_sprite.play('standing_front')
			'D':
				player_sprite.play("standing_side")
				player_sprite.flip_h = false

	
	move_and_slide()
	global_position = round(global_position)


	# UPDATE LABELS
	carrot_font.text = str(inventory[0])
	if (inventory[selectedItem] <= 0):
		selectedItem = -1
