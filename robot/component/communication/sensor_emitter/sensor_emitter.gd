extends Node
class_name SensorEmitter

@onready var visibility_manager: VisibilityManager = get_tree().get_first_node_in_group("visibility_manager")
@onready var comp_base: CompBase = $CompBase

var cam: CameraComp = null

func _ready() -> void:
	call_deferred("get_siblings")

func get_siblings() -> void:
	cam = comp_base.get_first_sib_group("camera_comp")

func _physics_process(_delta: float) -> void:
	if cam:
		visibility_manager.update_visibility(cam.global_polygon())
