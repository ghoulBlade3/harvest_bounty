extends Node
class_name health_component
@onready var stats_holder: Node2D = $"/root/main/camera/stats_holder"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player: player = $"/root/main/player"
@onready var hit: AudioStreamPlayer2D = $"/root/main/hit"

@export var kMaxHealth: int = 100
var health: int
var parent
var children
var sprite
var ranNum = RandomNumberGenerator.new()

func _ready():
	parent = get_parent()
	children = parent.get_children()
	for child in children:
		if child is AnimatedSprite2D:
			sprite = child
	health = kMaxHealth

func damage(attack_damage, knockback_amnt, knockback_dir):
	health -= attack_damage
	
	var pitch = ranNum.randf_range(2.9, 3.2)
	audio_stream_player.pitch_scale = pitch
	audio_stream_player.play()
	
	stats_holder.update_stat("health")
	
	sprite.self_modulate = Color("ff0000ff")
	get_tree().create_timer(0.2).timeout.connect(func(): sprite.self_modulate = Color("ffffffff"))
	knockback_dir = knockback_dir.normalized() * knockback_amnt
	knockback_dir = knockback_dir.lerp(Vector2.ZERO, 0.5)
	parent.velocity = knockback_dir
	parent.move_and_slide()
	parent.stunned = true
	
	if health <= 0:
		
		if parent is player:
			get_tree().reload_current_scene()
		
		pitch = ranNum.randf_range(1.9, 2.2)
		hit.pitch_scale = pitch
		hit.play()
		
		player.money += 5
		player.kills += 1
		stats_holder.update_stat("money")
		stats_holder.update_stat("kills")
		parent.queue_free()

func heal(heal_amnt):
	health += heal_amnt
	stats_holder.update_stat("health")
	sprite.self_modulate = Color("00ca31ff")
	get_tree().create_timer(0.2).timeout.connect(func(): sprite.self_modulate = Color("ffffffff"))
