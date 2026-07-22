@icon("res://addons/at-icons/node2d/checkerboard.svg")

class_name Board
extends TileMapLayer

static var current_board: Board

var tiles: Array[Vector2i]


func _ready() -> void:
	current_board = self
	tiles = _get_valid_board_tiles()


func _get_valid_board_tiles() -> Array[Vector2i]:
	var used_tiles: Array[Vector2i] = get_used_cells()
	for tile in used_tiles:
		var is_board_tile: bool = get_cell_tile_data(tile).get_custom_data("is_tile")

		if is_board_tile:
			tiles.append(tile)
	return used_tiles
