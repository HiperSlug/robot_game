@tool
extends ExitableOverlay

func _on_line_edit_text_changed(new_text: String) -> void:
	print(new_text)

func _on_host_pressed() -> void:
	hide()
	Network.host_match()
	
