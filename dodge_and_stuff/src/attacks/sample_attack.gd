@tool
extends Attack

func _run():
	while true:
		var speed = 5
		spawn_bullet(Vector2(0, -4), Vector2(0, speed))
		spawn_bullet(Vector2(1, -4), Vector2(0, speed))
		await pause(1.0)
		spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
		spawn_bullet(Vector2(1, -4), Vector2(0, speed))
		spawn_bullet(Vector2(-4, 0), Vector2(speed, 0))
		await pause(1.0)
		spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
		spawn_bullet(Vector2(-0, -4), Vector2(0, speed))
		await pause(1.0)
