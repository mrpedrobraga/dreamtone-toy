@tool
extends Attack

func _run():
	while true:
		spawn_bullet(Vector2(0, -4), Vector2(0, 4))
		spawn_bullet(Vector2(1, -4), Vector2(0, 4))
		await pause(1.0)
		spawn_bullet(Vector2(-1, -4), Vector2(0, 4))
		spawn_bullet(Vector2(1, -4), Vector2(0, 4))
		spawn_bullet(Vector2(-4, 0), Vector2(4, 0))
		await pause(1.0)
		spawn_bullet(Vector2(-1, -4), Vector2(0, 4))
		spawn_bullet(Vector2(-0, -4), Vector2(0, 4))
		await pause(1.0)
