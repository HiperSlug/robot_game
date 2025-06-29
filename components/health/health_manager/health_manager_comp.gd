extends Node
class_name HealthManagerComp

var health_comps: Array = []

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"health_comp"):
		var arr = dict[&"health_comp"]
		if arr is Array:
			health_comps = arr
	
	if health_comps.is_empty():
		printerr("Unable to assign health_components")

signal zeroed()

func change_health(amount: float) -> void:
	if not is_multiplayer_authority():
		print("client auth: healthhand")
		return
	
	for comp: HealthComp in health_comps:
		if not comp.is_zero():
			if is_zero_approx(amount):
				return
			
			amount = comp.change_health(amount)
			if is_zero_approx(amount) and not comp.is_zero():
				return
	
	zeroed.emit()
