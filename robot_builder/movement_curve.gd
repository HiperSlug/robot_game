extends Line2D
class_name PreviewLine

@onready var ray_cast_2d: RayCast2D = $RayCast2D
const line_length: float = 1000
@onready var collision_polygon_2d: CollisionPolygon2D = $Area2D/CollisionPolygon2D

func _ready() -> void:
	do_direction(Vector2.UP)

var direction: Vector2 = Vector2.UP

func do_direction(direction: Vector2) -> void:
	self.direction = direction
	ray_cast_2d.target_position = direction * line_length
	ray_cast_2d.force_raycast_update()
	
	var local_end_position: Vector2 = \
	ray_cast_2d.get_collision_point() - ray_cast_2d.global_position if ray_cast_2d.is_colliding() \
	else ray_cast_2d.target_position
	
	points = PackedVector2Array([Vector2(0, 0), local_end_position])
	collision_polygon(Vector2(0,0), local_end_position)

func collision_polygon(start: Vector2, stop: Vector2) -> void:
	collision_polygon_2d.polygon = PackedVector2Array([
		start + Vector2.RIGHT.rotated(rotation) * 10,
		start + Vector2.LEFT.rotated(rotation) * 10,
		stop + Vector2.LEFT.rotated(rotation) * 10,
		stop + Vector2.RIGHT.rotated(rotation) * 10,
		])
	

var capturing_mouse: bool = false

func _process(_delta: float) -> void:
	if capturing_mouse:
		do_direction(global_position.direction_to(get_global_mouse_position()))

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("rmb"):
		capturing_mouse = true
	elif event.is_action_released("rmb"):
		capturing_mouse = false
