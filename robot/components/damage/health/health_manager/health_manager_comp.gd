extends Node
class_name HealthHandlerComp

@onready var comp_base: CompBase = $CompBase

var health_components: Array

signal zeroed()

func get_sib() -> void:
	health_components = comp_base.get_sibs_group("health_comp")

func change_health(amount: float) -> void:
	for comp: HealthComp in health_components:
		if not comp.is_zero():
			if is_zero_approx(amount):
				return
			
			amount = comp.change_health(amount)
			if is_zero_approx(amount) and not comp.is_zero():
				return
	
	zeroed.emit()
