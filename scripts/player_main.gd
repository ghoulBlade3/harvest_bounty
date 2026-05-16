extends CharacterBody2D
class_name player
@onready var player_sprite: AnimatedSprite2D = $player_sprite
@onready var directional_animation_component: dir_anim_compoment = $directional_animation_component
@onready var health_component: health_component = $health_component


const kAttack = preload("res://scenes/player_attack.tscn")
var hasBoughtSomethingForTheFirstTime: bool = false

const kSpeed: float = 4800.0
var speed: float = kSpeed
#var health: = 64
var money: int = 80
var canInteract: bool = true

var selectedItem: int = -1
var items = {
	"empty": 0,
	"carrot": 1,
	"torrac": 2
}

var inventory: Array = [null, 0, 0]
var lastLookDir: Vector2 = Vector2.DOWN
var last_velocity_normalized = Vector2.ZERO
var instant
var can_attack: bool = true
var stunned: bool = false
@export var attack_cooldown: float = 0.5

# creates an instance of the attack, rotates it in the facing dir, and offsets away from player
func play_attack_animation(pMoveDir):
	var attack_dir: Vector2
	if can_attack:
		can_attack = false
		get_tree().create_timer(attack_cooldown).timeout.connect(func(): can_attack = true)
		if pMoveDir == Vector2.ZERO:
			attack_dir = lastLookDir
		else:
			lastLookDir = pMoveDir
			attack_dir = pMoveDir
		
		var attack_instance = kAttack.instantiate()
		attack_instance.knockback_dir = attack_dir
		attack_instance.global_position += attack_dir.normalized() * 10 # offsets the animation so that it plays away from player 
		attack_instance.rotation = attack_dir.angle() + deg_to_rad(90) # for some reason godot takes angles in radians
		add_child(attack_instance)

func _ready():
	#health = health_component.health
	player_sprite.sprite_frames.set_animation_loop("watering_side", false)
	player_sprite.play()

func _physics_process(delta: float) -> void:
	if stunned:
		get_tree().create_timer(0.2).timeout.connect(func(): stunned = false)
		return
		# PLAYER MOVEMENT
	var pMoveDir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	pMoveDir = pMoveDir.normalized()
	pMoveDir *= speed * delta
	velocity = pMoveDir
		
	if Input.is_action_just_pressed("attack"):
		play_attack_animation(pMoveDir)

	if canInteract:
		directional_animation_component.dir_animation(pMoveDir)

	# JITTER FIX
	if velocity.normalized() != last_velocity_normalized:
		position.x = round(position.x)
		position.y = round(position.y)


	last_velocity_normalized = velocity.normalized()
	move_and_slide()




var kFastSpeed = speed * 1.5
var carrotTimer: Timer = Timer.new()

func consume_food(foodItem: String):
	match foodItem:
		"carrot":
			speed = kFastSpeed
			print("Carrot consume")
			return
		"torrac":
			print("Torrac consume")
			return
