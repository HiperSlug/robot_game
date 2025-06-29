@tool
extends PanelContainer
class_name Category

@export var title: String = "":
	set(value):
		title = value
		$VBoxContainer/Label.text = title

@onready var label: Label = $VBoxContainer/Label
