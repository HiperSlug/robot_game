#extends Area2D
#class_name ActionEmitter
#
#
#@onready var nav: NavManagerComp = await CompGetter.new(
	#self.get_parent(),
	#Globals.Comp.NAV_MANAGER,
	#CompGetter.FIRST,
#).ready
#
#var receivers: Array = []
#
#func _on_area_entered(area: Area2D) -> void:
	#if area is ActionReceiver:
		#receivers.append(area)
		#
		#if nav:
			#area.receive_nav_callable(nav.get_direction)
#
#func _on_area_exited(area: Area2D) -> void:
	#if area is ActionReceiver:
		#receivers.erase(area)
		#
		#area.stop_receiving()
