extends Node2D
class_name RifleComp

@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D

func set_active(active: bool) -> void:
	if active:
		if timer.is_stopped():
			shoot()
			timer.start()
	else:
		timer.stop()


const BULLET = preload("res://components/weapon/rifle/bullet.tscn")

func shoot() -> void:
	var bullet = BULLET.instantiate()
	bullet.inital_dir(Vector2.UP.rotated(global_rotation))
	bullet.position = marker_2d.global_position
	get_tree().get_first_node_in_group("visibility_manager").add_child(bullet, true)

func _on_timer_timeout() -> void:
	shoot()
