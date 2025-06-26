extends Node
class_name NavHandlerComp


@onready var robot: CharacterBody2D = $".."
@onready var comp_base: CompBase = $CompBase

var speed: float = 0

func get_sib() -> void:
	navs = comp_base.get_sibs_group("navigation_comp")
	engines = comp_base.get_sibs_group("engine_comp")
	for engine in engines:
		speed += engine.speed
	for nav in navs:
		push_func(nav._direction)


var navs: Array
var engines: Array

func _physics_process(_delta: float) -> void:
	
	var dir := get_direction()
	
	robot.velocity = speed * dir
	robot.move_and_slide()

func get_direction() -> Vector2:
	if override:
		return override_func.call()
	else:
		var direction: Vector2 = Vector2.ZERO
		for dir_func in funcs:
			var dir: Vector2 = dir_func.call()
			direction += dir
		
		return direction.normalized()

var funcs: Array[Callable]

func push_func(callable: Callable) -> void:
	funcs.append(callable)

func erase_func(callable: Callable) -> void:
	funcs.erase(callable)


var override: bool = false
var override_func: Callable

func start_override(callable: Callable) -> void:
	override = true
	override_func = callable

func stop_override() -> void:
	override = false
