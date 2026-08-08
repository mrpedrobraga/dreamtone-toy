extends AnimatedSprite2D

@export var enemy: Enemy

func _on_brian_state_changed(new_state: Enemy.State) -> void:
	match new_state:
		Enemy.State.Idle:
			play("idle")
		Enemy.State.Hurt:
			play("hurt")
			_tween_dodge(-8, "y")
			$Hurt.play()

func _tween_dodge(amount: float, axis: String):
	var t = create_tween()
	t.tween_property(self, "position:" + axis, amount, enemy.hurt_duration / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "position:" + axis, 0, enemy.hurt_duration / 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
