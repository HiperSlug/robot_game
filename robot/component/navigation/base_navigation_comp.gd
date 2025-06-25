extends Node
class_name BaseNavComp

@onready var robot: Robot = $".."
@onready var comp_base: CompBase = $CompBase

var engine: BaseEngineComp = null

func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	engine = comp_base.get_first_sib_group("engine_comp")

func _physics_process(_delta: float) -> void:
	robot.move_and_slide()
