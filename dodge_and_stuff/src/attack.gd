@tool
extends Node
class_name Attack

## Represents a particular attack from a character.

## Reference to the battle that owns this attack.
@export var battle: DodgeBattle

## Called when the attack begins. Should be overriden.
##
## This is the function that will spawn hazards!
func _run():
	pass

var tick_timer = 0
var tick_length = 0.1
var current_tick = 0
signal tick(current_tick: float)

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	tick_timer += delta
	while tick_timer > tick_length:
		tick_timer -= tick_length
		current_tick += 1
		tick.emit(current_tick)

# __ HELPERS __

## Summons a bullet, throwing it in some direction!
func spawn_bullet(where: Vector2, velocity: Vector2):
	var h = SimpleBulletHazard.new()
	h.position = where
	add_child(h)
	# h.schedule_death()
	h.battle = battle
	h.velocity = velocity

## Waits for a little while.
func pause(time: float):
	await get_tree().create_timer(time).timeout
