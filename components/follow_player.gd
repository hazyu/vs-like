extends Node
class_name FollowPlayer

@export var sprite: AnimatedSprite2D

var parent: CharacterBody2D = null

func _ready() -> void:
	parent = get_parent()

func _physics_process(delta: float) -> void:
	if parent == null: return
	if Globals.player == null: return
	
	var direction = parent.position.direction_to(Globals.player.global_position)

	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
		
	parent.position = parent.position.move_toward(Globals.player.position, 50 * delta)
	sprite.play("default")
