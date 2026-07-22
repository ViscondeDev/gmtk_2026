@icon("res://addons/at-icons/node2d/stars.svg")
class_name BoardEffects
extends TileMapLayer


func _ready() -> void:
	Board.effects_layer = self


func highlight_tiles(tiles: Array[Vector2i]) -> void:
	for tile in tiles:
		set_cell(tile, 0, Vector2i(3, 3))
