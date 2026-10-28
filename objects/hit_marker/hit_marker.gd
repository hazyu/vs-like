extends Node2D

var t = 1
var damage: int = 0
var x_dir = 0

func _ready() -> void:
	x_dir = signf(randf_range(-1, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str(damage)
	t += delta
	var wave = sin(t)
	position.y += -wave
	position.x += x_dir * wave

func _on_timer_timeout() -> void:
	queue_free()
