extends Node
class_name ServerDeathComp

@onready var main: Main = get_tree().get_first_node_in_group("main")

func _ready() -> void:
	(await CompGetter.new(
		self.get_parent(),
		Globals.Comp.HEALTH_MANAGER,
		CompGetter.FIRST,
	).ready).zeroed.connect(on_health_zeroed)

const MENU_SCENE: String = "res://world/world.tscn"

func on_health_zeroed() -> void:
	if not is_multiplayer_authority():
		print("client auth: death")
		return
	
	game_over.rpc()

@rpc("call_local")
func game_over() -> void:
	print("Game Over, TODO: Stop input go to MENU (TODO)")
	get_tree().paused = true
	await get_tree().create_timer(.5).timeout
	get_tree().paused = false
	Network.network_disconnect()
	main.remove_scenes()
	main.add_scene(MENU_SCENE)
