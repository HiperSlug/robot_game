extends Button
class_name SceneButton

@export_file("*.tscn") var scene: String
signal scn_pressed(scene: String)

func _pressed() -> void:
	scn_pressed.emit(scene)
