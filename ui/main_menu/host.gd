@tool
extends ExitableOverlay

@onready var main: Main = get_tree().get_first_node_in_group("main")
@onready var main_menu: MainMenu = $".."


func _on_line_edit_text_changed(new_text: String) -> void:
	print(new_text)

func _on_host_pressed() -> void:
	Network.create_server()
	main.create_match()
	main_menu.hide()
	hide()
