extends PanelContainer


signal choice(scene: PackedScene, pos: Vector2)


func _on_mouse_exited() -> void:
	queue_free()


func _on_scene_button_scn_pressed(scene: PackedScene) -> void:
	choice.emit(scene, global_position)
	queue_free()
