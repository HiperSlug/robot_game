extends Camera2D
class_name ControlledCamera

@export var clamp_zoom: bool = false
@export var min_zoom: float
@export var max_zoom: float



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mmb"):
		start_dragging()
	elif event.is_action_released("mmb"):
		stop_dragging()
	elif event is InputEventMouseMotion:
		if dragging:
			drag(event.relative)
	
	elif event.is_action_pressed("zoom_in"):
		do_zoom(1 - zoom_ratio)
	elif event.is_action_pressed("zoom_out"):
		do_zoom(1 + zoom_ratio)

var dragging: bool = false
var drag_anchor: Vector2

func start_dragging() -> void:
	dragging = true
	drag_anchor = get_global_mouse_position()

func stop_dragging() -> void:
	dragging = false

func drag(relative: Vector2) -> void:
	position -= (relative / zoom).rotated(rotation)


@export var zoom_ratio: float = .2

func do_zoom(ratio: float) -> void:
	
	zoom *= ratio
	
	if clamp_zoom:
		zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
