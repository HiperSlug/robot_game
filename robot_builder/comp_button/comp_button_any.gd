@tool
extends Button
class_name CompButtonAny

@export var component: Component:
	set(value):
		component = value
		if component:
			component.changed.connect(on_changed) # That was a huge pain to learn this signal existed

func on_changed() -> void: 
	if component:
		text = component.name

func _toggled(_toggled_on: bool) -> void:
	pass
