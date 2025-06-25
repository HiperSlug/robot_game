extends Node
class_name HealthComp

@export var max_health: float = 10
var health: float

func _ready() -> void:
	set_health_clamped(max_health)

func set_health_clamped(health: float) -> float:
	var clamped := clampf(health, 0, max_health)
	self.health = clamped
	
	return health - clamped

func change_health(delta: float) -> float:
	return set_health_clamped(health + delta)

func is_zero() -> bool:
	return is_zero_approx(health)
