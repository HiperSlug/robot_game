extends PanelContainer


signal choice(scene: String, pos: Vector2)


func _on_mouse_exited() -> void:
	queue_free()


func _on_scene_button_scn_pressed(scene: String) -> void:
	choice.emit(scene)
	queue_free()
