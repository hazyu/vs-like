extends Node
class_name FollowPlayer

@export var sprite: AnimatedSprite2D

var parent: Enemy = null

func _ready() -> void:
	parent = get_parent()

func _physics_process(delta: float) -> void:
	if parent == null: return
	if Globals.player == null: return
	if Globals.is_game_paused: return
	
	var direction = parent.global_position.direction_to(Globals.player.global_position)

	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
		
	parent.position = parent.position.move_toward(Globals.player.position, parent.movespeed * delta)
	sprite.play("default")
