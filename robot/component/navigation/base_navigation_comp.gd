extends Node
class_name BaseNavComp

# NavStraightComp

@onready var robot: Robot = $".."
@onready var comp_base: CompBase = $CompBase


var engine: BaseEngineComp = null

func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	engine = comp_base.get_first_sib_group("engine_comp")


func _physics_process(_delta: float) -> void:
	if disabled:
		return
	
	var dir := get_direction()
	
	direction.emit(dir)
	
	if engine:
		robot.velocity = dir * engine.speed


signal direction(dir: Vector2)

# override
func _direction() -> Vector2:
	return Vector2.ZERO

func get_direction() -> Vector2:
	if override:
		return override_direction.call()
	else:
		return _direction()


var disabled: bool = false

func set_disabled(disabled: bool) -> void:
	self.disabled = disabled


var override: bool = false
var override_direction: Callable

func start_override(callable: Callable) -> void:
	override = true
	override_direction = callable

func stop_override() -> void:
	override = false
