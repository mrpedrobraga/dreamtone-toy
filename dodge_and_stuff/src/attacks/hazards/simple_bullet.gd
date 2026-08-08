@tool
extends Hazard
class_name SimpleBulletHazard

@export var velocity: Vector2

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	super(delta)
	position += velocity * delta

func schedule_death():
	get_tree().create_timer(4.0).timeout.connect(func(): queue_free())
