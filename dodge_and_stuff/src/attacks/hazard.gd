@tool
extends Node
class_name Hazard

## Something that can harm the player in the dodging minigames!

@export var battle: DodgeBattle

## The position of the hazard.
## 
## This coordinate system is not the screen's, but,
## a custom one where Vector2.ZERO is the player's default position,
## Vector2.LEFT is the player's position when dodging left, etc.
##
## Though hazards can have non-integer positions.
@export var position: Vector2

## Size of the hazard.
##
## A box is created where the centre of the box is the hazard's "position."
@export var size: Vector2 = Vector2(0.5, 0.5)

var _is_currently_overlapping_character: bool = true
var _was_overlapping_character_last_frame: bool = false
var _hit_character_at_any_point = false

const character_size = Vector2(1.0, 1.0)

@export var texture = preload("uid://bcwf4ahdm4lt")

func _physics_process(_delta: float) -> void:
	var is_overlapping = is_overlapping_character(battle.current_char)
	if is_overlapping and not _was_overlapping_character_last_frame:
		_hit_character_at_any_point = true
		_handle_began_overlapping_character()
	_was_overlapping_character_last_frame = _is_currently_overlapping_character
	_is_currently_overlapping_character = is_overlapping

func _handle_began_overlapping_character():
	battle.harm_character()

func _handle_dodged_successfull():
	battle.successful_dodge(self)

func is_overlapping_character(character: CharacterInstance):
	var character_position = Vector2.ZERO
	
	match character.state:
		CharacterInstance.State.DodgeRight:
			character_position = Vector2.RIGHT
		CharacterInstance.State.DodgeLeft:
			character_position = Vector2.LEFT
		CharacterInstance.State.DodgeDown:
			character_position = Vector2.DOWN
	
	var character_rect = Rect2(character_position - character_size / 2, character_size)
	var self_rect = Rect2(position - size / 2, size)
	return character_rect.intersects(self_rect)
