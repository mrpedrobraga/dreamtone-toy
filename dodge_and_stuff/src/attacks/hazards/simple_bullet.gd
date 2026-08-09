@tool
extends Hazard
class_name SimpleBulletHazard

@export var velocity: Vector2
var life = 0

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	super(delta)
	position += velocity * delta
	
	life += delta
	if position.y > 1:
		if not _hit_character_at_any_point:
			_handle_dodged_successfull()
		die()
	if life >= 3.0:
		die()

func die():
	queue_free()
