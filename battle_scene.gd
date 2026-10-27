extends Node2D

func _ready() -> void:
	Globals.player = $Player
	Globals.projectiles = $Projectiles
	Globals.battle_scene = self
