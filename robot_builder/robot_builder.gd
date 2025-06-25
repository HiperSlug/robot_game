extends Control
class_name RobotBuilder

const COMP_LIB = preload("res://robot_builder/lib/comp_lib.tres")
const CATEGORY = preload("res://robot_builder/category.tscn")
@onready var v_box_container: VBoxContainer = $HSplitContainer/PanelContainer2/VBoxContainer/VBoxContainer
var category_nodes: Dictionary[Category.CATEGORIES, Category] = {}

func _ready() -> void:
	var components := COMP_LIB.components as Array[Component]
	for component: Component in components:
		var category: Category = get_category(component.category)
		category.add_component(component)

func get_category(category: Category.CATEGORIES) -> Category:
	var category_node = category_nodes.get(category)
	if category_node:
		return category_node
	
	category_node = CATEGORY.instantiate()
	category_nodes[category] = category_node
	v_box_container.add_child(category_node)
	category_node.initalize(self, category)
	return category_node

@onready var active_container: VBoxContainer = $HSplitContainer/PanelContainer/VBoxContainer/VBoxContainer/VBoxContainer
var selected_components: Dictionary[Component, ActiveComponent] = {}
const ACTIVE_COMPONENT = preload("res://robot_builder/active_component.tscn")
func on_component_toggled(component: Component, toggled_on: bool) -> void:
	if not toggled_on:
		if selected_components.has(component):
			
			selected_components[component].queue_free()
			selected_components.erase(component)
	else:
		var act_comp: ActiveComponent = ACTIVE_COMPONENT.instantiate()
		active_container.add_child(act_comp)
		act_comp.initalize(component.name)
		selected_components[component] = act_comp
	
	#print(selected_components)


@onready var world: CanvasLayer = get_tree().get_first_node_in_group("world")

func _on_finish_robot_pressed() -> void:
	start_preview()

const PLACEMENT_PREVIEW: PackedScene = preload("res://robot_builder/placement_preview.tscn")
func start_preview() -> void:
	var preview: PlacementPreview = PLACEMENT_PREVIEW.instantiate()
	preview.initalize(selected_components.keys())
	world.add_child(preview)
