extends Node
class_name NavManagerComp


@onready var robot: CharacterBody2D = self.get_parent()
@onready var navs: Array = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.NAV,
	CompGetter.ALL,
).ready
@onready var engines: Array = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.ENGINE,
	CompGetter.ALL,
).ready

var speed: float = 0

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


func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	
	var dir := get_direction()
	
	robot.velocity = speed * dir
	if dir != Vector2.ZERO:
		
		robot.rotation = lerp_angle(robot.rotation, dir.angle() + (TAU/4) , TAU  * delta)
		#robot.rotation = dir.angle() + (TAU / 4)
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
