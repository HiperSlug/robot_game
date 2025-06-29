#extends Node
#class_name SensorEmitter
#
#@onready var visibility_manager: VisibilityManager = get_tree().get_first_node_in_group("visibility_manager")
#@onready var cam: CameraComp = await CompGetter.new(
	#self.get_parent(),
	#Globals.Comp.CAM, # TODO
	#CompGetter.FIRST,
#).ready
#
#func _physics_process(_delta: float) -> void:
	#if cam:
		#visibility_manager.update_visibility(cam.global_polygon())
