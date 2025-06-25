extends Area2D
class_name BaseAttackComp

@export var damage: float = 30

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComp:
		if area in exceptions:
			return
		
		area.damage(damage)
		return
	
	print(area)

var exceptions: Array[HurtboxComp] = []

@onready var comp_base: CompBase = $CompBase

func _ready() -> void:
	call_deferred("get_sib")
	call_deferred("activate")

func get_sib() -> void:
	var self_hurtbox = comp_base.get_first_sib_group("hurtbox_comp")
	if self_hurtbox:
		exceptions.append(self_hurtbox)

func activate() -> void:
	monitoring = true
