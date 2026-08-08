@icon("res://dodge_and_stuff/sprites/you-icon.png")
extends Node
class_name CharacterInstance

## An instance of a character in the game.

@export var display_name = "Mike"
## If this number reaches 0, you're out of commission!
@export var hp = 10
## How much HP you can hold.
@export var max_hp = 10
## Adrenaline-type energy that powers special skills.
@export var en = 10
## How much EN you can hold.
@export var max_en = 10

signal hp_changed(amount: float)

## __ Internal __

var state: State

enum State {
	Idle,
	DodgeRight,
	DodgeLeft,
	DodgeDown,
	Counter
}

@export var scheme: ControlScheme = ControlScheme.TimedDodge

enum ControlScheme {
	## Classic DREAMTONE control scheme!
	TimedDodge,
	## Holding the button keeps you at a position!
	HeldDodge,
}

signal state_changed(new_state: State)

@export_category("Fine Tuning")
## How long dodging takes.
## Faster dodges means more precise control.
## Only meaningul in the 'Timed Dodge' scheme.
@export var dodge_duration = 0.5
## How long countering takes.
@export var counter_duration = 0.25
var state_timer = 0.0

func _physics_process(delta: float) -> void:
	match scheme:
		ControlScheme.TimedDodge:
			_handle_inputs_timed_dodge()
			_process_timed_dodge(delta)
		ControlScheme.HeldDodge:
			_handle_inputs_held_dodge()
			_process_held_dodge(delta)

func _process_timed_dodge(delta: float) -> void:
	match state:
		State.Idle:
			pass
		State.Counter:
			state_timer -= delta
			if state_timer <= 0:
				_set_state(State.Idle, 0)
		State.DodgeRight:
			state_timer -= delta
			if state_timer <= 0:
				_set_state(State.Idle, 0)
		State.DodgeLeft:
			state_timer -= delta
			if state_timer <= 0:
				_set_state(State.Idle, 0)
		State.DodgeDown:
			state_timer -= delta
			if state_timer <= 0:
				_set_state(State.Idle, 0)

func _process_held_dodge(delta: float) -> void:
	match state:
		State.Idle:
			pass
		State.Counter:
			state_timer -= delta
			if state_timer <= 0:
				_set_state(State.Idle, 0)

func _handle_inputs_timed_dodge():
	if Input.is_action_just_pressed("ok"):
		counter()
	if state == State.Idle:
		if Input.is_action_just_pressed("move_right"):
			_set_state(State.DodgeRight, dodge_duration)
		if Input.is_action_just_pressed("move_left"):
			_set_state(State.DodgeLeft, dodge_duration)
		if Input.is_action_just_pressed("move_down"):
			_set_state(State.DodgeDown, dodge_duration)

func _handle_inputs_held_dodge():
	if state == State.Idle and Input.is_action_just_pressed("ok"):
		counter()
		return
	if state == State.Counter:
		return
	var new_state = State.Idle
	if Input.is_action_pressed("move_right"):
		new_state = State.DodgeRight
	elif Input.is_action_pressed("move_left"):
		new_state = State.DodgeLeft
	elif Input.is_action_pressed("move_down"):
		new_state = State.DodgeDown
	
	if new_state != state:
		_set_state(new_state, dodge_duration)

func counter() -> void:
	if state == State.Idle:
		_set_state(State.Counter, counter_duration)

func harm() -> void:
	hp -= 1
	hp_changed.emit(1)

func _set_state(new_state: State, timer: float):
	state_timer = timer
	state = new_state
	state_changed.emit(new_state)
