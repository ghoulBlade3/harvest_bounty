extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $player_sprite
@onready var player_center: Node2D = $player_center
#@onready var carrot_font: RichTextLabel = $"../camera/Control/carrot_font"


const kSpeed: float = 4800.0
var health: int = 5
var canInteract: bool = true

var selectedItem: int = -1
var items = {
	"empty": 0,
	"carrot": 1,
	"torrac": 2
}
var inventory: Array = [null, 0, 0]
var lastLookDir: String = 'S'
var distanceFromFarmland: float
var last_velocity_normalized = Vector2.ZERO



func _ready():
	player_sprite.play()

func _physics_process(delta: float) -> void:
	# PLAYER MOVEMENT
	var pMoveDir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	pMoveDir = pMoveDir.normalized()
	pMoveDir = pMoveDir * kSpeed * delta
	velocity = pMoveDir


	# SET SPRITES BASED ON MOVE DIR
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


	# SET SPRITES WHEN STANDING STILL
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

	# JITTER FIX
	if velocity.normalized() != last_velocity_normalized:
		position.x = round(position.x)
		position.y = round(position.y)

	last_velocity_normalized = velocity.normalized()
	move_and_slide()
	
	
	
	# CHECK DISTANCE OF NEAREST CROPS
	
