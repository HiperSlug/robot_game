extends Node
class_name ServerDeathComp

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"health_manager_comp"):
		var arr = dict[&"health_manager_comp"]
		if arr is Array and arr.size() == 1 and arr[0] is HealthManagerComp:
			arr[0].zeroed.connect(on_health_zeroed)
		else:
			printerr("Unable to assign health_manager")
	else:
		printerr("Unable to assign health_manager")


const MENU_SCENE: String = "res://world/world.tscn"
func on_health_zeroed() -> void:
	if not is_multiplayer_authority():
		return
	
	game_over.rpc()

@rpc("call_local")
func game_over() -> void:
	print("Game over")
	
	Network.offline()
	Main.leave_game()
