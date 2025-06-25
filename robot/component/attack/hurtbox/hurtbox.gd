extends Area2D
class_name HurtboxComp

var healths: Array[Node] = []
@onready var comp_base: CompBase = $CompBase

func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	healths = comp_base.get_sibs_group("health_comp")

func damage(dmg: float) -> void:
	for health in healths:
		if not health.is_zero():
			var leftover_dmg = - health.change_health(- dmg)
			if leftover_dmg == 0:
				return
			
			dmg = leftover_dmg
			
