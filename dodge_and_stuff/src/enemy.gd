@icon("res://dodge_and_stuff/sprites/enemy-icon.png")
extends Node
class_name Enemy

## Represents an enemy in the battle.

@export var display_name = "Brian"
## If this number reaches 0, they're out of commission!
@export var hp = 30:
	set(v):
		hp = min(v, max_hp)
## How much HP it can hold.
@export var max_hp = 40

signal hp_changed(amount: float)

## __ Internal __

var state: State

enum State {
	Idle,
	Hurt,
	Dead,
}

signal state_changed(new_state: State)

## How long the enemy is hurt for.
@export var hurt_duration = 0.5
var state_timer = 0.0

func _physics_process(delta: float) -> void:
	match state:
		State.Idle:
			pass
		State.Hurt:
			state_timer -= delta
			if state_timer <= 0:
				_set_state(State.Idle, 0)

func harm(power) -> void:
	hp -= power
	hp_changed.emit(power)
	_set_state(State.Hurt, hurt_duration)

func die():
	state_changed.emit(State.Dead)

func _set_state(new_state: State, timer: float):
	state_timer = timer
	state = new_state
	state_changed.emit(new_state)
