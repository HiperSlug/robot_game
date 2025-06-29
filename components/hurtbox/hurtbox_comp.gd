extends Area2D
class_name HurtboxComp

var health_manager: HealthManagerComp = null

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"health_manager_comp"):
		var arr = dict[&"health_manager_comp"]
		if arr is Array and arr.size() == 1 and arr[0] is HealthManagerComp:
			health_manager = arr[0]
	
	if not health_manager:
		printerr("Unable to assign health_manager")


func damage(dmg: float) -> void:
	if not is_multiplayer_authority():
		return
	
	health_manager.change_health(- dmg)
