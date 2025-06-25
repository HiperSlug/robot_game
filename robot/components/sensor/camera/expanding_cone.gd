@tool
extends Polygon2D
class_name ExpandingCone2D

signal changed(new_polygon: PackedVector2Array)

@export var distance: float = 10
@export_range(0, max_vertices, 1) var vertices: int:
	set(value):
		vertices = value
		setup()
@export var collision_mask: int = 8
const max_vertices: int = 64
const angle_per: float = TAU / max_vertices

func _ready() -> void:
	setup()

func setup() -> void:
	for child: Node in get_children():
		if not child is RayCast2D:
			continue
		child.queue_free()
	
	for i: int in range(vertices):
		var degree: float = i - floor(vertices / 2.0) + (.5 * ((vertices + 1) % 2 ))
		var angle: float = angle_per * degree
		var target: Vector2 = Vector2.UP.rotated(angle) * distance
		
		var raycast := RayCast2D.new()
		raycast.target_position = target
		raycast.set_collision_mask_value(1, false)
		raycast.set_collision_mask_value(collision_mask, true)
		
		add_child(raycast)

func _process(_delta: float) -> void:
	var new_polygon: Array = []
	
	for child: Node in get_children():
		if not child is RayCast2D:
			continue
		var end_point := get_local_end_point(child)
		new_polygon.append(end_point)
	
	if vertices != max_vertices:
		new_polygon.append(Vector2.ZERO)
	
	if polygon == PackedVector2Array(new_polygon):
		return
	
	polygon = PackedVector2Array(new_polygon)
	changed.emit(polygon)

func get_local_end_point(raycast: RayCast2D) -> Vector2:
	if raycast.is_colliding():
		return raycast.get_collision_point() - raycast.global_position
	return raycast.target_position
