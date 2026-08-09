extends AnimatedSprite2D
class_name CharacterVisuals

## Visualizes the state of a character.

@export var character: CharacterInstance

func _process(_delta: float) -> void:
	if GoInputBuffer.is_action_buffered("ok"):
		modulate.r = 0.5
	else:
		modulate.r = 1.0
	
	if character.invincibility_timer > 0:
		modulate.a = 0.5
	else:
		modulate.a = 1.0

func _on_mike_state_changed(new_state: CharacterInstance.State) -> void:
	match character.scheme:
		CharacterInstance.ControlScheme.TimedDodge:
			_handle_state_change_timed_dodge(new_state)
		CharacterInstance.ControlScheme.HeldDodge:
			_handle_state_change_held_dodge(new_state)

func _handle_state_change_timed_dodge(new_state: CharacterInstance.State) -> void:
	match new_state:
		CharacterInstance.State.Idle:
			play("idle")
		CharacterInstance.State.DodgeRight:
			play("dodge_right")
			_tween_dodge(dodge_horizontal_offset_px, "x")
			$DodgeRight.play()
		CharacterInstance.State.DodgeLeft:
			play("dodge_left")
			_tween_dodge(-dodge_horizontal_offset_px, "x")
			$DodgeLeft.play()
		CharacterInstance.State.DodgeDown:
			play("dodge_down")
			_tween_dodge(dodge_vertical_offset_px, "y")
			$DodgeDown.play()
		CharacterInstance.State.Counter:
			play("counter")
			_tween_counter()
			$Jump.play()

func _handle_state_change_held_dodge(new_state: CharacterInstance.State) -> void:
	match new_state:
		CharacterInstance.State.Idle:
			play("idle")
			_tween_reset_move()
			$DodgeDown.play()
		CharacterInstance.State.DodgeRight:
			play("dodge_right")
			_tween_move(dodge_horizontal_offset_px * Vector2.RIGHT)
			$DodgeRight.play()
		CharacterInstance.State.DodgeLeft:
			play("dodge_left")
			_tween_move(dodge_horizontal_offset_px * Vector2.LEFT)
			$DodgeLeft.play()
		CharacterInstance.State.DodgeDown:
			play("dodge_down")
			_tween_move(dodge_vertical_offset_px * Vector2.DOWN)
			$DodgeDown.play()
		CharacterInstance.State.Counter:
			play("counter")
			_tween_counter()
			$Jump.play()

const dodge_horizontal_offset_px = 32;
const dodge_vertical_offset_px = 24;

func _tween_dodge(amount: float, axis: String):
	var t = create_tween()
	t.tween_property(self, "position:" + axis, amount, character.dodge_duration / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "position:" + axis, 0, character.dodge_duration / 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)

func _tween_move(where: Vector2):
	var t = create_tween()
	t.tween_property(self, "position", where, character.dodge_duration / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func _tween_reset_move():
	var t = create_tween()
	t.tween_property(self, "position", Vector2.ZERO, character.dodge_duration / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func _tween_counter():
	var t = create_tween()
	t.tween_property(self, "position", dodge_vertical_offset_px * Vector2.UP, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "position", Vector2.ZERO, character.counter_duration / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func _on_mike_hp_changed(_amount: float) -> void:
	$Hurt.play()
