@icon("res://addons/at-icons/node2d/checkerboard.svg")

class_name Board
extends TileMapLayer

signal cell_clicked(cell: Vector2i)

const NULL_CELL := Vector2i(-1, -1)

static var current_board: Board
static var effects_layer: BoardEffects
@export var accept_clicks: bool = true

var tiles: Array[Vector2i]
var pieces: Dictionary[Vector2i, Piece]


func _ready() -> void:
	current_board = self
	tiles = _get_valid_board_tiles()


func _process(_delta: float) -> void:
	if accept_clicks and Input.is_action_just_pressed("mouse_pressed"):
		var cell: Vector2i = _get_clicked_cell()
		if cell != NULL_CELL:
			cell_clicked.emit(cell)


func _get_valid_board_tiles() -> Array[Vector2i]:
	var used_tiles: Array[Vector2i] = get_used_cells()

	var valid_tiles: Array[Vector2i]
	for tile in used_tiles:
		if get_cell_tile_data(tile).get_custom_data("is_tile"):
			valid_tiles.append(tile)
	return valid_tiles


func _get_clicked_cell() -> Vector2i:
	var clicked_cell: Vector2i = local_to_map(get_local_mouse_position())
	if clicked_cell in tiles:
		return clicked_cell
	return NULL_CELL
