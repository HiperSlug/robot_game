extends Area2D
class_name HurtboxComp

var health_manager: HealthHandlerComp

@onready var comp_base: CompBase = $CompBase

func get_sib() -> void:
	health_manager = comp_base.get_first_sib_group("health_manager_comp")

func damage(dmg: float) -> void:
	if not is_multiplayer_authority():
		print("client auth: hurtbox")
		return
	health_manager.change_health(- dmg)
