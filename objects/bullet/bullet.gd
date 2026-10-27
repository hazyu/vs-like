extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var move_vec = transform.x * 200
	global_position += move_vec * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		queue_free()
