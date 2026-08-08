@tool
extends Node2D
class_name AttackView

@export var attack: Node
@export var target_character_instance: CharacterInstance
@export var target_character_node: Node2D

func _physics_process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	_draw_hazards()

const dodge_horizontal_offset_px = 32;
const dodge_vertical_offset_px = 24;

func _draw_hazards():
	for child in attack.get_children():
		var hazard: Hazard = child
		var texture = hazard.texture
		var origin = target_character_node.global_position
		var texture_modulate = Color.WHITE
		
		if hazard._is_currently_overlapping_character:
			texture_modulate = Color.RED
		
		draw_texture(
			hazard.texture,
			origin - hazard.texture.get_size() / 2 + hazard.position * Vector2(dodge_horizontal_offset_px, dodge_vertical_offset_px),
			texture_modulate
		)
