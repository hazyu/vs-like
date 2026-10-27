extends CharacterBody2D

@export var bullet_scene: PackedScene
@export var speed: float = 200

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var closest_enemy: CharacterBody2D = null
var enemy_diff: float = 1000000.0

func _physics_process(delta: float) -> void:
	var mx = int(Input.is_action_pressed("mv_right")) - int(Input.is_action_pressed("mv_left"))
	var my = int(Input.is_action_pressed("mv_down")) - int(Input.is_action_pressed("mv_up"))
	
	if mx > 0:
		animated_sprite_2d.flip_h = false
	elif mx < 0:
		animated_sprite_2d.flip_h = true

	if mx != 0 or my != 0:
		animated_sprite_2d.play("default")
	else:
		animated_sprite_2d.stop()
		animated_sprite_2d.frame = 0
	
	velocity = Vector2(mx, my) * speed
	move_and_slide()

func _on_enemy_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var diff = position.distance_to(body.global_position)
		if diff < enemy_diff:
			enemy_diff = diff
			closest_enemy = body
			print(body)

func _on_enemy_area_body_exited(body: Node2D) -> void:
	if body == closest_enemy:
		closest_enemy = null
		enemy_diff = 10000.0

func _on_timer_timeout() -> void:
	if closest_enemy == null: return
	if Globals.projectiles == null: return
	
	var bullet: Area2D = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.look_at(closest_enemy.global_position)
	Globals.projectiles.add_child(bullet)
	





	
