@tool
extends ExitableOverlay

@onready var name_edit: LineEdit = $ProfileEdit/MarginContainer/HBoxContainer/NameEdit
@onready var profile_button: Button = $"../Profile"



func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		if visible:
			name_edit.grab_focus()
			name_edit.edit()

func _on_name_edit_text_changed(new_text: String) -> void:
	profile.set_display_name(new_text)
	profile.save()

@onready var profile: Profile = Profile.load_profile()
func _ready() -> void:
	profile_button.text = profile.display_name

func _on_name_edit_text_submitted(_new_text: String) -> void:
	_exit()

func _exit() -> void:
	hide()
	name_edit.text = ""
	profile_button.text = profile.display_name
