extends Resource
class_name Profile

@export var display_name: String = "Guest"
func set_display_name(new_name) -> void:
	display_name = new_name


const path: String = "user://profile.tres"

func save() -> void:
	ResourceSaver.save(self, path)

static func load_profile() -> Profile:
	if ResourceLoader.exists(path):
		var res: Profile = ResourceLoader.load(path, "Profile") as Profile
		return res
	var profile := Profile.new()
	return profile
