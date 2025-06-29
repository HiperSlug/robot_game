@tool
extends ExitableOverlay

func _on_join_pressed() -> void:
	Network.join_match("localhost")
	hide()
