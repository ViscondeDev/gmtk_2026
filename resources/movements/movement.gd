@icon("res://addons/at-icons/node/arrow_cross.svg")
@abstract class_name Movement
extends Resource


static func _validate_cells_in_line(
	start_position: Vector2i,
	axis: Vector2i,
	is_friendly: bool,
) -> Array[Vector2i]:
	var valid_moves: Array[Vector2i]
	var next_tile := start_position + axis
	if next_tile in Board.current_board.tiles:
		var is_blocked = next_tile in Board.current_board.pieces.keys()
		if is_blocked:
			if Board.current_board.pieces[next_tile].is_friendly != is_friendly:
				valid_moves.append(next_tile)
				Board.current_board.pieces[next_tile].is_thretened = true
		else:
			valid_moves.append(next_tile)
			valid_moves = valid_moves + _validate_cells_in_line(next_tile, axis, is_friendly)
	return valid_moves
