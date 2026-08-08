@icon("res://dodge_and_stuff/sprites/enemy-icon.png")
extends Node
class_name Enemy

## Represents an enemy in the battle.

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
	Hurt
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

func harm() -> void:
	hp -= 1
	hp_changed.emit(1)
	_set_state(State.Hurt, hurt_duration)

func _set_state(new_state: State, timer: float):
	state_timer = timer
	state = new_state
	state_changed.emit(new_state)
