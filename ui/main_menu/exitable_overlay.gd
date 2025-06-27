@tool
extends ExitableOverlay

@onready var main: Main = get_tree().get_first_node_in_group("main")
@onready var main_menu: MainMenu = $".."

func _on_join_pressed() -> void:
	Network.create_client("localhost")
	main.create_match()
	main_menu.hide()
	hide()
