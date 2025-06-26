extends Node
class_name Main

func remove_scenes() -> void:
	for child in get_children():
		child.queue_free()

func add_scene(scene_path: String) -> void:
	var scene = load(scene_path)
	if scene is PackedScene:
		var node = scene.instantiate()
		add_child(node)
