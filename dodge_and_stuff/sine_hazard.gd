@tool
extends Hazard

var __internal_time = 0.0

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	super(delta)
	
	__internal_time += delta
	position.x = sin(__internal_time * 2) * 2
