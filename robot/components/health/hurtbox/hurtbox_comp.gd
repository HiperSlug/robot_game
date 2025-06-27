extends Area2D
class_name HurtboxComp

@onready var health_manager: HealthManagerComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.HEALTH_MANAGER,
	CompGetter.FIRST,
).ready

func damage(dmg: float) -> void:
	if not is_multiplayer_authority():
		print("client auth: hurtbox")
		return
	health_manager.change_health(- dmg)
