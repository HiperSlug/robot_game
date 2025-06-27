@tool
extends Node
class_name HealthComp

@export var max_health: float = 10
@export var health: float

func _ready() -> void:
	set_health_clamped(max_health)

@rpc("authority")
func set_health_clamped(health: float) -> float:
	var clamped := clampf(health, 0, max_health)
	self.health = clamped
	
	return health - clamped

func change_health(delta: float) -> float:
	if not is_multiplayer_authority():
		print("bad authority: health_comp")
		return 0
	
	set_health_clamped.rpc(health + delta)
	return set_health_clamped(health + delta)

func is_zero() -> bool:
	return is_zero_approx(health)
