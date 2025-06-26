@tool
extends CollisionPolygon2D
class_name CameraCone

@export var radius: float = 10:
	set(value):
		radius = value
		setup()
@export_range(0, TAU, rad_per_vert) var angle: float:
	set(value):
		angle = value
		setup()

const collision_mask: int = 6
const rad_per_vert: float = TAU / 128

func _ready() -> void:
	setup()

func setup() -> void:
	for child: Node in get_children(): # idk if neccecary
		if not child is RayCast2D:
			continue
		child.queue_free() 
	
	var verts: int = int(roundf(angle / rad_per_vert))
	
	for i: int in range(verts):
		var degree: float = i - floor(verts / 2.0) + (.5 * ((verts + 1) % 2 ))
		var angle: float = rad_per_vert * degree
		var target: Vector2 = Vector2.UP.rotated(angle) * radius
		
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
	
	if not is_equal_approx(angle, TAU):
		new_polygon.append(Vector2.ZERO)
	
	polygon = PackedVector2Array(new_polygon)

func get_local_end_point(raycast: RayCast2D) -> Vector2:
	if raycast.is_colliding():
		return raycast.get_collision_point() - raycast.global_position
	return raycast.target_position
