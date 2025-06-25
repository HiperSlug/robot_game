extends Area2D
class_name HurtboxComp

var health_manager: HealthManagerComp

@onready var comp_base: CompBase = $CompBase

func _ready() -> void:
	call_deferred("get_sib")
	
func get_sib() -> void:
	health_manager = comp_base.get_first_sib_group("health_manager_comp")

func damage(dmg: float) -> void:
	health_manager.change_health(- dmg)
