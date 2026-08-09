@tool
extends Control
class_name DodgeBattle

## An example of a turn-based system built around dodging!

@export var main_char: CharacterInstance
var current_char: CharacterInstance = null

var you_won = false

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
	#$Battle/Enemies/Brian.hp += 4
	update_score()

func successful_dodge(_hazard):
	current_char.en = min(current_char.en + 1, current_char.max_en)

func _on_mike_attack_enemy(power) -> void:
	if you_won:
		return
	
	$Battle/Enemies/Brian.harm(power)
	update_score()
	
	if $Battle/Enemies/Brian.hp <= 0:
		win()

func win():
	you_won = true
	$Battle/Music.stop()
	$Battle/Enemies/Brian.die()
	$Battle/Attack.queue_free()

	await get_tree().create_timer(2.0).timeout
	$BG.texture = preload("uid://dafaqkxjctff7")
	$"Battle/You Won".play()
	$Narration.text = "You Won! Brian is fucking dead!"

func update_score():
	$Narration.text = "Brian's HP: %s" % [ $Battle/Enemies/Brian.hp ]
