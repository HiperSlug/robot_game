extends PanelContainer
class_name Category

const COMPONENT_BUTTON = preload("res://robot_builder/component_button.tscn")
@onready var label: Label = $VBoxContainer2/Label
@onready var v_box_container: VBoxContainer = $VBoxContainer2/VBoxContainer


var robot_builder: RobotBuilder

func initalize(robot_builder: RobotBuilder, category: CATEGORIES) -> void:
	self.robot_builder = robot_builder
	set_display(category)
	

func set_display(category: CATEGORIES) -> void:
	match category:
		CATEGORIES.HEALTH:
			label.text = "HEALTH"
		CATEGORIES.SPEED:
			label.text = "SPEED"
		CATEGORIES.NAVIGATION:
			label.text = "NAVIGATION"
		CATEGORIES.COMMUNICATION:
			label.text = "COMMUNICATION"
		CATEGORIES.CAMERA:
			label.text = "CAMERA"

func add_component(component: Component) -> void:
	var button: Button = COMPONENT_BUTTON.instantiate()
	
	button.initalize(component)
	button.component_toggled.connect(robot_builder.on_component_toggled)
	
	v_box_container.add_child(button)


enum CATEGORIES{
	HEALTH,
	SPEED,
	NAVIGATION,
	COMMUNICATION,
	CAMERA
}
