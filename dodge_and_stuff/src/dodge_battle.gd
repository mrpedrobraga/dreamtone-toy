@tool
extends Control
class_name DodgeBattle

## An example of a turn-based system built around dodging!

@export var main_char: CharacterInstance
var current_char: CharacterInstance = null

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	current_char = main_char
	$Battle/Attack._run()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func harm_character():
	current_char.harm()
	update_score()

func _on_mike_attack_enemy() -> void:
	$Battle/Enemies/Brian.harm()
	update_score()

func update_score():
	$Narration.text = "Enemy HP: %s; Your Hp: %s" % [ $Battle/Enemies/Brian.hp, current_char.hp ]
