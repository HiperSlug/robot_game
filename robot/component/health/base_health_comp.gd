extends Node
class_name BaseHealthComp

@export var max_health: float = 10
var health: float

func _ready() -> void:
	set_health_clamped(max_health)

func set_health_clamped(health: float) -> void:
	health = clampf(health, 0, max_health)
	self.health = health

func change_health(delta: float) -> void:
	set_health_clamped(health + delta)
