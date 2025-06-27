extends Node
class_name Main

@onready var main_menu: MainMenu = $MainMenu

func remove_scenes() -> void:
	for child in get_children():
		child.queue_free()

func add_scene(scene_path: String) -> void:
	var scene = load(scene_path)
	if scene is PackedScene:
		var node = scene.instantiate()
		add_child(node, true)

var world: CanvasLayer = null
const WORLD = preload("res://world/world.tscn")
func create_match() -> void:
	if world:
		world.queue_free()
	world = WORLD.instantiate()
	add_child(world, true)

func end_match() -> void:
	if world:
		world.queue_free()
	main_menu.show()
