extends Area2D
class_name Hitbox


signal entered(hurtbox: HurtboxComp)

var exceptions: Array[HurtboxComp] = []

func add_exception(exception: HurtboxComp) -> void:
	exceptions.append(exception)


var overlaps: Array[HurtboxComp] = []

func _on_area_entered(area: Area2D) -> void:
	if not is_multiplayer_authority():
		return
	
	if area is HurtboxComp:
		if area in exceptions:
			return
		
		overlaps.append(area)
		
		enter(area)

func _on_area_exited(area: Area2D) -> void:
	if not is_multiplayer_authority():
		return
	
	if area is HurtboxComp:
		overlaps.erase(area)

@export var enter_dmg: float = 0

@export var dps: float = 0
@export var tick_time: float = .1

@onready var timer: Timer = $Timer

func _ready() -> void:
	if not is_multiplayer_authority():
		return
	
	if not is_zero_approx(dps):
		timer.wait_time = tick_time
		timer.start()
		inside(overlaps)

func _on_timer_timeout() -> void:
	inside(overlaps)


func enter(hurtbox: HurtboxComp) -> void:
	if not is_multiplayer_authority():
		return
	hurtbox.damage(enter_dmg)
	entered.emit(hurtbox)

func inside(hurtboxes: Array[HurtboxComp]) -> void:
	if not is_multiplayer_authority():
		return
	for hurtbox in hurtboxes:
		hurtbox.damage(dps * tick_time)
