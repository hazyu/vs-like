extends Node2D

var t = 0
var damage: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str(damage)
	t += delta
	var wave = sin(t)
	position.y += -wave


func _on_timer_timeout() -> void:
	queue_free()
