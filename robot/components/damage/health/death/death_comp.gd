extends Node
class_name DeathComp

@onready var comp_base: CompBase = $CompBase
@onready var robot = $".."

var health_handler_comp: HealthHandlerComp # BaseHealthComp

func get_sib() -> void:
	health_handler_comp = comp_base.get_first_sib_group("health_manager_comp")
	health_handler_comp.zeroed.connect(on_health_zeroed)

func on_health_zeroed() -> void:
	robot.queue_free() # and presumably an animation and drop and stuff
