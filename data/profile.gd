extends Resource
class_name Profile

@export var display_name: String = "Guest"
func set_display_name(new_name) -> void:
	display_name = new_name

const path: String = "user://profile.tres"

func save() -> void:
	ResourceSaver.save(self, path)

static func load_profile() -> Profile:
	if ResourceLoader.exists(path, "Profile"):
		var result = ResourceLoader.load(path, "Profile")
		if result:
			return result
	var profile := Profile.new()
	return profile
