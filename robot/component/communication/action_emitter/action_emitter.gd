extends Area2D
class_name ActionEmitter

var receivers: Array[ActionReceiver] = []

func _on_area_entered(area: Area2D) -> void:
	if area is ActionReceiver:
		receivers.append(area)
		
		if nav:
			area.receive_nav_callable(nav.get_direction)

func _on_area_exited(area: Area2D) -> void:
	if area is ActionReceiver:
		receivers.erase(area)
		
		area.stop_receiving()

var nav: BaseNavComp = null
@onready var comp_base: CompBase = $CompBase

func _ready() -> void:
	call_deferred("get_sib")
	#call_deferred("starting_areas")

func get_sib() -> void:
	nav = comp_base.get_first_sib_group("nav_comp")

#func starting_areas() -> void:
	#for area in get_overlapping_areas():
		#_on_area_entered(area)
