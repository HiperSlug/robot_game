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
	
	if engine:
		_nav_velocity()
		
	robot.move_and_slide()

# override
func _nav_velocity() -> void:
	pass

var disabled: bool = false

func set_disabled(disabled: bool) -> void:
	self.disabled = disabled
