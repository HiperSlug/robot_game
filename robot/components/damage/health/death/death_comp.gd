extends Node
class_name DeathComp

@onready var comp_base: CompBase = $CompBase
@onready var robot: Robot = $".."

var health_manager_comp: HealthManagerComp # BaseHealthComp

func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	health_manager_comp = comp_base.get_first_sib_group("health_manager_comp")
	health_manager_comp.zeroed.connect(on_health_zeroed)

func on_health_zeroed() -> void:
	robot.queue_free() # and presumably an animation and drop and stuff
