extends Node
class_name health_component

@export var kMaxHealth: float = 10.0
var health: float

func _ready():
	health = kMaxHealth
