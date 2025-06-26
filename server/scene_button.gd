extends Button
class_name SceneButton

@export var scene: PackedScene
signal scn_pressed(scene: PackedScene)


func _pressed() -> void:
	scn_pressed.emit(scene)
