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
	print("Game over: TODO ADD SCREEN")
	
	Network.network_disconnect()
	main.end_match()
