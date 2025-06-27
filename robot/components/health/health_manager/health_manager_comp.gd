extends Node
class_name HealthManagerComp

var health_components: Array[HealthComp] = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.HEALTH,
	CompGetter.ALL,
).ready

signal zeroed()

func change_health(amount: float) -> void:
	if not is_multiplayer_authority():
		print("client auth: healthhand")
		return
	
	for comp: HealthComp in health_components:
		if not comp.is_zero():
			if is_zero_approx(amount):
				return
			
			amount = comp.change_health(amount)
			if is_zero_approx(amount) and not comp.is_zero():
				return
	
	zeroed.emit()
