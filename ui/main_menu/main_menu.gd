extends Control
class_name MainMenu

@onready var profile_edit: ExitableOverlay = $ProfileEdit
@onready var host: ColorRect = $Host
@onready var join: ColorRect = $Join

func _on_host_pressed() -> void:
	host.show()


func _on_join_pressed() -> void:
	join.show()


func _on_freeplay_pressed() -> void:
	print("TODO")


func _on_profile_pressed() -> void:
	profile_edit.show()


func _on_settings_pressed() -> void:
	print("TODO")
