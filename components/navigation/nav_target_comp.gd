@tool
extends NavigationAgent2D
class_name NavTargetComp

var target: Node2D = null
var character: CharacterBody2D = null

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"target_comp"):
		var arr = dict[&"target_comp"]
		if arr is Array and arr.size() == 1 and arr[0] is Node:
			target = arr[0]
	if dict.has(&"character"):
		var character = dict[&"character"]
		if character and character is CharacterBody2D:
			self.character = character
	
	if not target:
		printerr("Unable to assign target")
	if not character:
		printerr("Unable to assign character")

@export var distance: float = 10:
	set(val):
		distance = val
		target_desired_distance = distance

const leeway := 10.0

func _direction() -> Vector2:
	if not target:
		return Vector2.ZERO
	
	var pos = target.target()
	
	if not pos:
		return Vector2.ZERO
	pos = pos as Vector2
	
	if is_target_reached():
		var dist: float = pos.distance_to(character.global_position)
		if dist < distance - leeway: # too close
			return pos.direction_to(character.global_position)
		elif dist > distance: # too far
			target_position = pos
		else: # just right
			return Vector2.ZERO
	
	target_position = pos
	
	var dir := character.global_position.direction_to(get_next_path_position())
	return dir
