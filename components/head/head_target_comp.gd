extends Marker2D
class_name HeadTargetComp

@onready var weapons: Array = []
@onready var target: Node = null

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"target_comp"):
		var arr = dict[&"target_comp"]
		if arr is Array and arr.size() == 1 and arr[0] is Node:
			target = arr[0]
	if dict.has(&"weapon_comp"):
		var arr = dict[&"weapon_comp"]
		if arr is Array:
			weapons = arr
	
	if not target:
		printerr("Unable to assign target")

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		if target:
			look_at(target.target())
			rotate(TAU / 4)
	
	for weapon: Node2D in weapons:
		weapon.global_rotation = global_rotation
