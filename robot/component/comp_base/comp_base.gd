extends Node
class_name CompBase

func get_first_sib_group(group_name: String) -> Node:
	var parent = $"../.."
	
	for child: Node in parent.get_children():
		if child.is_in_group(group_name):
			return child
	
	return null
