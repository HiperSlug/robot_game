@tool
extends Resource
class_name Component

@export var name: String = "Comp":
	set(value):
		name = value
		resource_name = name

@export var scene: PackedScene
