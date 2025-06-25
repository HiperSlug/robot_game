extends Area2D
class_name NavReceiver

var nav: BaseNavComp
var engine: BaseEngineComp
@onready var comp_base: CompBase = $CompBase
@onready var robot: Robot = $".."


func _ready() -> void:
	call_deferred("get_sib")

func get_sib() -> void:
	nav = comp_base.get_first_sib_group("nav_comp")
	engine = comp_base.get_first_sib_group("engine_comp")




func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("lmb"):
		if not is_receiving:
			start_receiving()
		else:
			stop_receiving()


var is_receiving: bool = false
func start_receiving() -> void:
	is_receiving = true
	if nav:
		nav.set_disabled(true)

func stop_receiving() -> void:
	is_receiving = false
	if nav:
		nav.set_disabled(false)

func _process(_delta: float) -> void:
	if not is_receiving:
		return
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if engine:
		robot.velocity = input_dir * engine.speed
		robot.move_and_slide()
