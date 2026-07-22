@icon("res://addons/at-icons/node2d/chess_knight.svg")
class_name Knight
extends Piece


static func get_valid_tiles(start_position: Vector2i) -> Array[Vector2i]:
	Board.effects_layer.clear()
	var possible_moves_unvalidated := [
		Vector2i(2, 1),
		Vector2i(2, -1),
		Vector2i(1, 2),
		Vector2i(1, -2),
		Vector2i(-2, 1),
		Vector2i(-2, -1),
		Vector2i(-1, 2),
		Vector2i(-1, -2),
		]
	var valid_moves: Array[Vector2i]
	for axis: Vector2i in possible_moves_unvalidated:
		var next_tile := start_position + axis
		if next_tile in Board.current_board.tiles:
			valid_moves.append(next_tile)
	Board.effects_layer.highlight_tiles(valid_moves)
	return valid_moves
