extends Node
class_name NavHandlerComp


@onready var robot: Robot = $".."
@onready var comp_base: CompBase = $CompBase

func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	nav = comp_base.get_first_sib_group("navigation_comp")
	engine = comp_base.get_first_sib_group("engine_comp")
	# set nav type

var nav: NavComp
var engine: EngineComp

func _physics_process(_delta: float) -> void:
	
	var dir := get_direction()
	
	if engine:
		robot.velocity = dir * engine.speed

func get_direction() -> Vector2:
	if override:
		return override_func.call()
	elif nav:
		return nav._direction()
	else:
		return Vector2.ZERO


var override: bool = false
var override_func: Callable

func start_override(callable: Callable) -> void:
	override = true
	override_func = callable

func stop_override() -> void:
	override = false
