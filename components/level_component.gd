extends Node
class_name LevelComponent

var parent: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var needed_xp = Globals.player_level * 100
	var p = (Globals.xp / needed_xp) * 100
	parent.value = p
	
	if p >= 100:
		Globals.is_game_paused = true
		Globals.battle_scene.dim_rect.visible = true
