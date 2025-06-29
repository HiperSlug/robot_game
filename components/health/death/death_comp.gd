extends Node
class_name DeathComp

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"health_manager_comp"):
		var arr = dict[&"health_manager_comp"]
		if arr is Array and arr.size() == 1 and arr[0] is HealthManagerComp:
			arr[0].zeroed.connect(on_health_zeroed)
		else:
			printerr("Unable to assign health manager")
	else:
		printerr("Unable to assign health manager")
	if dict.has(&"character"):
		var character = dict[&"character"]
		if character and character is CharacterBody2D:
			self.character = character
	
	if not character:
		printerr("Unable to assign character")

var character: CharacterBody2D = null


func on_health_zeroed() -> void:
	if not is_multiplayer_authority():
		return
	
	character.queue_free()
