@icon("res://addons/at-icons/node2d/chess_rook.svg")
class_name Rook
extends Piece


func get_valid_tiles(start_position: Vector2i) -> Array[Vector2i]:
	Board.effects_layer.clear()
	var possible_moves_unvalidated := [
		Vector2i(1, 0),
		Vector2i(-1, 0),
		Vector2i(0, 1),
		Vector2i(0, -1),
	]
	var valid_moves: Array[Vector2i]
	for axis: Vector2i in possible_moves_unvalidated:
		valid_moves = valid_moves + _validate_cells_in_line(
			start_position,
			axis,
		)
	Board.effects_layer.highlight_tiles(valid_moves)
	return valid_moves
