extends Area2D
class_name ActionEmitter


var receivers: Array = []

func _on_area_entered(area: Area2D) -> void:
	if area is ActionReceiver:
		receivers.append(area)
		
		if nav:
			area.receive_nav_callable(nav.get_direction)

func _on_area_exited(area: Area2D) -> void:
	if area is ActionReceiver:
		receivers.erase(area)
		
		area.stop_receiving()


var nav: NavHandlerComp = null
@onready var comp_base: CompBase = $CompBase


func get_sib() -> void:
	nav = comp_base.get_first_sib_group("nav_handler_comp")
