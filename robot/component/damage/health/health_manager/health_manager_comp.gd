extends Node
class_name HealthManagerComp

@onready var comp_base: CompBase = $CompBase

var health_components: Array[Node]

signal zeroed()

func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	health_components = comp_base.get_sibs_group("health_comp")

func change_health(amount: float) -> void:
	for comp: BaseHealthComp in health_components:
		if not comp.is_zero():
			var leftover := comp.change_health(amount)
			if is_zero_approx(leftover):
				return
			
			amount = leftover
	
	zeroed.emit()
