extends Node
class_name DeathComp

@onready var comp_base: CompBase = $CompBase
@onready var robot: Robot = $".."

var health_comps: Array[Node] # BaseHealthComp

func _ready() -> void:
	call_deferred("get_sib")


func get_sib() -> void:
	health_comps = comp_base.get_sibs_group("health_comp")
	for comp in health_comps:
		comp.zeroed.connect(on_comp_zeroed)

func on_comp_zeroed() -> void:
	for comp in health_comps:
		if not comp.is_zero():
			return
	
	robot.queue_free()
