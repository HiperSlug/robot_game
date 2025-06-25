extends CheckButton

signal component_toggled(component, toggled_on: bool)

var component

func initalize(component: Component) -> void:
	self.component = component
	text = component.name

func _toggled(toggled_on: bool) -> void:
	component_toggled.emit(component, toggled_on)
