@tool
extends Resource
class_name Component

@export var name: StringName:
	set(value):
		name = value
		resource_name = value
@export var scene: PackedScene
@export var category: Category.CATEGORIES
