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
}

signal state_changed(new_state: State)

const dodge_duration = 0.5
const counter_duration = 0.25
var state_timer = 0.0

func _physics_process(delta: float) -> void:
	match scheme:
		ControlScheme.TimedDodge:
			_process_timed_dodge(delta)

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

func _process_held_dodge(_delta: float) -> void:
	pass

func counter() -> void:
	if state == State.Idle:
		_set_state(State.Counter, counter_duration)

func dodge_right() -> void:
	if state == State.Idle:
		_set_state(State.DodgeRight, dodge_duration)

func dodge_left() -> void:
	if state == State.Idle:
		_set_state(State.DodgeLeft, dodge_duration)

func dodge_down() -> void:
	if state == State.Idle:
		_set_state(State.DodgeDown, dodge_duration)

func harm() -> void:
	hp -= 1
	hp_changed.emit(1)

func _set_state(new_state: State, timer: float):
	state_timer = timer
	state = new_state
	state_changed.emit(new_state)
