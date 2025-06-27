extends Node
class_name DeathComp

@onready var robot = $".."
@onready var health_manager: HealthManagerComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.HEALTH_MANAGER,
	CompGetter.FIRST,
).ready


func on_health_zeroed() -> void:
	if not is_multiplayer_authority():
		print("client auth: death comp")
		return
	
	robot.queue_free() # and presumably an animation and drop and stuff
