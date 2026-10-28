extends CharacterBody2D
class_name Player

@export var bullet_scene: PackedScene
@export var speed: float = 200

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var mx = 0
var my = 0
func _set_camera_zoom():
	var size = get_window().size
	var zoom = size.y / 360
	$Camera2D.zoom = Vector2(zoom, zoom)

func _ready() -> void:
	_set_camera_zoom()
	get_tree().root.size_changed.connect(_set_camera_zoom)

func _physics_process(delta: float) -> void:
	if Globals.is_game_paused: return
	mx = int(Input.is_action_pressed("mv_right")) - int(Input.is_action_pressed("mv_left"))
	my = int(Input.is_action_pressed("mv_down")) - int(Input.is_action_pressed("mv_up"))
	
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

func _on_timer_timeout() -> void:
	if len(Globals.enemies.get_children()) == 0: return
	if Globals.is_game_paused: return
	
	var closest_enemy: Enemy = null
	var distance = 100000.0
	for enemy: Enemy in Globals.enemies.get_children():
		var d = position.distance_to(enemy.global_position)
		if d < distance:
			distance = d
			closest_enemy = enemy
	if closest_enemy == null: return
	if Globals.projectiles == null: return
	
	var bullet: Area2D = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.look_at(closest_enemy.global_position)
	Globals.projectiles.add_child(bullet)
	





	
