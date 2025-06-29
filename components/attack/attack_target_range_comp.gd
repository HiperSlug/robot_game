extends Node2D
class_name AttackTargetRangeComp

var target: Node = null

var weapons: Array = []

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
	if weapons.is_empty():
		printerr("Unable to assign weapons")

@export var distance: float = 100

func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	var attack: bool = global_position.distance_squared_to(target.target()) < distance ** 2
	
	for weapon in weapons:
		weapon.set_active(attack)
	
