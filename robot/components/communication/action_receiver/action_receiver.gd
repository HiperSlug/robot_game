extends Area2D
class_name ActionReceiver


@onready var nav: NavManagerComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.NAV_MANAGER,
	CompGetter.FIRST,
).ready


var overriding_nav: bool = false
var direction_callable: Callable

func receive_nav_callable(callable: Callable) -> void:
	overriding_nav = true
	if nav:
		nav.start_override(callable)

func stop_receiving() -> void:
	overriding_nav = false
	if nav:
		nav.stop_override()
