extends CharacterBody2D
class_name Bullet

const speed: float = 1000

func inital_dir(dir: Vector2) -> void:
	velocity = dir.normalized() * speed
	rotation = dir.angle() + ( TAU / 4)

func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	move_and_slide()
	
	var collison = get_last_slide_collision()
	if collison:
		queue_free()

func _on_hitbox_entered(_hurtbox: HurtboxComp) -> void:
	queue_free()
