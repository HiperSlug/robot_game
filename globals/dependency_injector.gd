extends RefCounted
class_name DependencyInjector

static func handle_comp_dependencies(parent: Node, override_character: Node = null) -> void:
	var comp_dict: Dictionary[StringName, Variant]
	
	if override_character:
		comp_dict[&"character"] = override_character
	else:
		comp_dict[&"character"] = parent
	
	for comp: Node in parent.get_children():
		for group: StringName in comp.get_groups():
			if comp_dict.has(group):
				comp_dict[group].append(comp)
			else:
				comp_dict[group] = [comp]
	
	
	for comp: Node in parent.get_children():
		if comp.has_method("inject_dependencies"):
			comp.inject_dependencies(comp_dict)

# EXAMPLE
#func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	#if dict.has(&"*_comp"):
		#var arr = dict[&"*_comp"]
		#if arr is Array and arr.size() == 1 and arr[0] is Node:
			#comp = arr[0]
	#
	#if not comp:
		#printerr("Unable to assign comp")
