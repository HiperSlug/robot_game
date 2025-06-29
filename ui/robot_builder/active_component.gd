extends PanelContainer
class_name ActiveComponent

@onready var label: Label = $HBoxContainer/Label

func initalize(comp_name: String) -> void:
	label.text = comp_name
