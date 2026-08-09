@tool
extends Attack

func _run():
	await pause(2.0)
	var attacks: Array[Callable] = [big_attack, big_attack, small_attack]
	var index = 0
	while true:
		var current_attack = attacks[index % attacks.size()]
		await current_attack.call()
		await pause(3.0)
		index += 1;

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
