extends Area2D
class_name ActionReceiver

@onready var robot: Robot = $".."
@onready var comp_base: CompBase = $CompBase
var nav: BaseNavComp = null
var engine: BaseEngineComp = null

func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	nav = comp_base.get_first_sib_group("nav_comp")
	engine = comp_base.get_first_sib_group("engine")


var overriding_nav: bool = false
var direction_callable: Callable

func receive_nav_callable(callable: Callable) -> void:
	overriding_nav = true
	if nav:
		nav.start_override(callable)

func stop_receiving() -> void:
	overriding_nav = false
	if nav:
		nav.stop_override()
