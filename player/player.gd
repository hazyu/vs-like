extends CharacterBody2D

@export var speed: float = 200

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

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
