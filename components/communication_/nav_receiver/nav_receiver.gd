#extends Area2D
#class_name NavReceiver
#
#@onready var nav: NavManagerComp = await CompGetter.new(
	#self.get_parent(),
	#Globals.Comp.NAV_MANAGER,
	#CompGetter.FIRST,
#).ready
#
#
## this functionality will probably change later.
#func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#if event.is_action_pressed("lmb"):
		#if not is_receiving:
			#start_receiving()
		#else:
			#stop_receiving()
#
#
#var is_receiving: bool = true
#func start_receiving() -> void:
	#is_receiving = true
	#if nav:
		#nav.start_override(_direction)
#
#func stop_receiving() -> void:
	#is_receiving = false
	#if nav:
		#nav.stop_override()
#
#
#func _direction() -> Vector2:
	#var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#return input_dir
