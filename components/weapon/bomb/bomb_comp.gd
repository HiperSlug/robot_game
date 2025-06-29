extends Node2D
class_name Bomb

const EXPLOSION: PackedScene = preload("res://components/weapon/bomb/explosion.tscn")
@onready var cooldown: Timer = $Cooldown

func set_active(active: bool) -> void:
	if active and cooldown.is_stopped():
		cooldown.start()
		var explosion := EXPLOSION.instantiate()
		explosion.position = global_position
		get_tree().get_first_node_in_group(&"visibility_manager").add_child(explosion, true)
