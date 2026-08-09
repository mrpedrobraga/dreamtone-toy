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
signal attack_enemy()

## __ Internal __

var state: State

enum State {
	Idle,
	DodgeRight,
	DodgeLeft,
	DodgeDown,
	Counter
}

signal state_changed(new_state: State)

@export var scheme: ControlScheme = ControlScheme.TimedDodge

enum ControlScheme {
	## Classic DREAMTONE control scheme!
	TimedDodge,
	## Holding the button keeps you at a position!
	HeldDodge,
}

@export_category("Fine Tuning")
## How long dodging takes.
## Faster dodges means more precise control.
## Only meaningul in the 'Timed Dodge' scheme.
@export var dodge_duration = 0.5
## For how long you're invincible after taking a hit!
@export var invincibility = 0.5
## How long countering takes.
@export var counter_duration = 0.25
## For how many frames will the game hold onto unused input.
##
## This adds leniency for if the player tries to dodge another attack
## before they've settled in an idle position.
@export_range(0, 120) var dodge_input_buffer_size = 10
@export_range(0, 120) var counter_input_buffer_size = 10
## If you can counter without waiting for the character to be in the idle position.
@export var instant_countering: bool = false
var state_timer = 0.0
var invincibility_timer = 0.0

func _physics_process(delta: float) -> void:
	if invincibility_timer > 0:
		invincibility_timer = max(0, invincibility_timer - delta)
	
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

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if event.is_action("ok"):
			GoInputBuffer.buffer_event(event, counter_input_buffer_size)
		else:
			GoInputBuffer.buffer_event(event, dodge_input_buffer_size)

func _handle_inputs_timed_dodge():
	if dodge_input_buffer_size > 0:
		_handle_inputs_timed_dodge_buffered()
		return
	if Input.is_action_just_pressed("ok"):
		counter()
	if state == State.Idle:
		if Input.is_action_just_pressed("move_right"):
			_set_state(State.DodgeRight, dodge_duration)
		if Input.is_action_just_pressed("move_left"):
			_set_state(State.DodgeLeft, dodge_duration)
		if Input.is_action_just_pressed("move_down"):
			_set_state(State.DodgeDown, dodge_duration)

func _handle_inputs_timed_dodge_buffered():
	if state == State.Idle:
		if GoInputBuffer.is_action_buffered("ok", true):
			GoInputBuffer.clear_input_buffer()
			counter()
			return
		if GoInputBuffer.is_action_buffered("move_right", true):
			_set_state(State.DodgeRight, dodge_duration)
		if GoInputBuffer.is_action_buffered("move_left", true):
			_set_state(State.DodgeLeft, dodge_duration)
		if GoInputBuffer.is_action_buffered("move_down", true):
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
	_set_state(State.Counter, counter_duration)
	get_tree().create_timer(0.1).timeout.connect(func ():
		attack_enemy.emit()
	)

func harm() -> void:
	if invincibility_timer == 0:
		hp -= 1
		hp_changed.emit(1)
		GoInputBuffer.clear_input_buffer()
		invincibility_timer = invincibility

func _set_state(new_state: State, timer: float):
	state_timer = timer
	state = new_state
	state_changed.emit(new_state)
