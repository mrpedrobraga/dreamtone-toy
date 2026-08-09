@tool
extends Attack

func _run():
	await pause(2.0)
	while true:
		#var callable: Callable = [small_attack, big_attack].pick_random()
		var callable = unilateral
		await callable.call()
		await pause(3.0)

func unilateral():
	var speed = 5
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	await pause(1.5)
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	await pause(1.5)
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	await pause(1.5)

func small_attack():
	var speed = 5
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	spawn_bullet(Vector2(1, -4), Vector2(0, speed))
	await pause(0.5)
	spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	await pause(0.5)
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	spawn_bullet(Vector2(1, -4), Vector2(0, speed))
	await pause(0.5)
	spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	await pause(0.5)
	spawn_bullet(Vector2(-5, 0), Vector2(speed, 0))
	spawn_bullet(Vector2(5, 0), Vector2(-speed, 0))

func big_attack():
	var speed = 5
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	spawn_bullet(Vector2(1, -4), Vector2(0, speed))
	await pause(0.8)
	spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(-4, 0), Vector2(speed, 0))
	await pause(0.8)
	spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(-0, -4), Vector2(0, speed))
	await pause(2.4)
	spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(0, -4), Vector2(0, speed))
	await pause(0.8)
	spawn_bullet(Vector2(-1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(1, -4), Vector2(0, speed))
	spawn_bullet(Vector2(4, 0), Vector2(-speed, 0))
	await pause(0.8)
	spawn_bullet(Vector2(-0, -4), Vector2(0, speed))
	spawn_bullet(Vector2(1, -4), Vector2(0, speed))
	await pause(0.8)
