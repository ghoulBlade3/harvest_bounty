extends CharacterBody2D
class_name player1
@onready var player_sprite: AnimatedSprite2D = $player_sprite
@onready var directional_animation_component: dir_anim_compoment = $directional_animation_component

const kAttack = preload("res://scenes/player_attack.tscn")

var speed: float = 4800.0
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
var last_velocity_normalized = Vector2.ZERO

func _ready():
	player_sprite.sprite_frames.set_animation_loop("watering_side", false)
	player_sprite.play()


func _physics_process(delta: float) -> void:
	# PLAYER MOVEMENT
	var pMoveDir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	pMoveDir = pMoveDir.normalized()
	pMoveDir *= speed * delta
	velocity = pMoveDir

	if Input.is_action_just_pressed("attack"):
		add_child(kAttack.instantiate())
		pass

	if canInteract:
		directional_animation_component.dir_animation(pMoveDir)

	# JITTER FIX
	if velocity.normalized() != last_velocity_normalized:
		position.x = round(position.x)
		position.y = round(position.y)

	last_velocity_normalized = velocity.normalized()
	move_and_slide()
