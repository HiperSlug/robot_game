extends Node
class_name NavManagerComp

var character: CharacterBody2D = null

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"nav_comp"):
		var arr = dict[&"nav_comp"]
		if arr is Array:
			for nav in arr:
				push_func(nav._direction)
	
	if dict.has(&"engine_comp"):
		var arr = dict[&"engine_comp"]
		if arr is Array:
			for engine: EngineComp in arr:
				speed += engine.speed
	
	if dict.has(&"character"):
		var character = dict[&"character"]
		if character and character is CharacterBody2D:
			self.character = character
	
	if not character:
		printerr("Unable to assign character")

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


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	
	var dir := get_direction()
	
	character.velocity = speed * dir
	character.move_and_slide()

func get_direction() -> Vector2:
	if override:
		return override_func.call()
	else:
		var direction: Vector2 = Vector2.ZERO
		for dir_func in funcs:
			var dir: Vector2 = dir_func.call()
			direction += dir
		
		return direction.normalized()
