extends Node
class_name EnemySpawner

@export var enemy_scenes: Array[PackedScene]

func _ready() -> void:
	var timer = Timer.new()
	timer.timeout.connect(_on_timer_timeout)
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)

func _on_timer_timeout():
	if Globals.player == null: return
	var enemy_index = randi_range(0, len(enemy_scenes) - 1)
	var enemy_scene: PackedScene = enemy_scenes[enemy_index]
	var enemy: Enemy = enemy_scene.instantiate()
	if Globals.player.mx != 0 or Globals.player.my != 0:
		enemy.position = Globals.player.global_position + Vector2(Globals.player.mx * 100, Globals.player.my * 100)
	else:
		enemy.position = Globals.player.global_position + Vector2(signf(randf_range(-1,1)) * 100, signf(randf_range(-1, 1)) * 100)
	Globals.enemies.add_child(enemy)
	
