extends Node
class_name CompBase

@onready var parent: Node = $".."

func _ready() -> void:
	if parent.has_method("get_sib"):
		parent.call_deferred("get_sib")

func get_first_sib_group(group_name: String) -> Node:
	var robot = parent.get_parent()
	
	for child: Node in robot.get_children():
		if child.is_in_group(group_name):
			return child
	
	return null

func get_sibs_group(group_name: String) -> Array:
	var robot = parent.get_parent()
	
	var arr: Array = []
	
	for child: Node in robot.get_children():
		if child.is_in_group(group_name):
			arr.append(child)
	
	return arr
