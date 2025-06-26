extends Node
class_name ServerDeathComp

@onready var comp_base: CompBase = $CompBase
@onready var main: Main = get_tree().get_first_node_in_group("main")

var health_manager: HealthHandlerComp
const MENU_SCENE: String = "res://world/world.tscn"


func get_sib() -> void:
	health_manager = comp_base.get_first_sib_group("health_manager_comp")
	if health_manager:
		health_manager.zeroed.connect(on_health_zeroed)

func on_health_zeroed() -> void:
	print("Game Over")
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	main.remove_scenes()
	main.add_scene(MENU_SCENE)
