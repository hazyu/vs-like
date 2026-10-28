extends Area2D

@export var hit_marker_scene: PackedScene
@export var damage: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var move_vec = transform.x * 400
	global_position += move_vec * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		queue_free()
		body.health -= damage
		var hit_marker: Node2D = hit_marker_scene.instantiate()
		hit_marker.global_position = global_position
		hit_marker.damage = damage
		Globals.battle_scene.add_child(hit_marker)
		if body.health <= 0:
			body.queue_free()
			Globals.xp += 10

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
