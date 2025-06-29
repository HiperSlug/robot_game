extends Node
# autoload Main

@onready var main: Node = get_tree().get_first_node_in_group("main")
@onready var main_menu: Control = main.get_node("MainMenu")

const WORLD = preload("res://world/world.tscn")
var world: Node

func new_game() -> void:
	if world:
		world.queue_free()
	
	world = WORLD.instantiate()
	main.add_child(world, true)
	
	main_menu.hide()

func leave_game() -> void:
	if world:
		world.queue_free()
	
	main_menu.show()
