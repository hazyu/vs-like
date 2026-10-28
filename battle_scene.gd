extends Node2D
class_name BattleScene

@onready var dim_rect: ColorRect = $CanvasLayer/DimRect

func _ready() -> void:
	Globals.player = $Player
	Globals.projectiles = $Projectiles
	Globals.battle_scene = self
	Globals.enemies = $Enemies
