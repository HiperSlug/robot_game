@tool
extends ColorRect
class_name ExitableOverlay

func _ready() -> void:
	color = Color(0.145, 0.145, 0.145, 0.788)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_exit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_exit()

func _exit() -> void:
	hide()
