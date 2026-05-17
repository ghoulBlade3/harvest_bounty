extends Sprite2D
@onready var effect: Sprite2D = $"."
@export var effectType: String
@onready var effect_timer: Timer = $effect_timer
@onready var effect_text: RichTextLabel = $effect_text
@onready var player: player = $"../../../player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	effect.texture = load("res://textures/ui/effect_" + effectType + ".png")
	return


func timer_start(seconds: int) -> void:
	effect_timer.wait_time += (seconds - 1)
	effect_timer.start()
	return


func _physics_process(delta: float) -> void:
	effect_text.self_modulate = Color("83efff")
	effect_text.text = str(ceili(effect_timer.time_left))
	
	if effect_timer.time_left != 0.0:
		return
	
	effect_text.self_modulate = Color.WHITE
	match effectType:
		"speed":
			if player.speed == player.kFastSpeed:
				player.speed = player.kSpeed
		"scare":
			if player.scare_effect:
				player.scare_effect = false
	print(effect_timer.time_left)
	return
