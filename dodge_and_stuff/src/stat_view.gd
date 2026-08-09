extends TextureRect
class_name StatView

## Visualises a character's stats.

@export var character: CharacterInstance

func _process(delta: float) -> void:
	$Label.text = "%s/%s" % [character.en, character.max_en]
