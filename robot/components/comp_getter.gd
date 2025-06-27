extends RefCounted
class_name CompGetter

var comps: Array[Node] = []

var search: Node
var group: StringName

var is_ready: bool = false

signal ready(comps)

enum {
	FIRST,
	ALL,
}

func _init(_search: Node, comp: Globals.Comp, sorting: int) -> void:
	search = _search
	group = Globals.group(comp)
	
	match sorting:
		FIRST:
			call_deferred("get_first")
		ALL:
			call_deferred("get_all")

func get_all() -> void:
	comps.clear()
	for node in search.get_children():
		if node.is_in_group(group):
			comps.append(node)
	is_ready = true
	ready.emit(comps)

func get_first() -> void:
	comps.clear()
	for node in search.get_children():
		if node.is_in_group(group):
			comps = [node]
			is_ready = true
			ready.emit(comps[0])
			return
	ready.emit(null)

func first() -> Node:
	if comps.is_empty():
		return null
	return comps[0]

func all() -> Array[Node]:
	return comps
