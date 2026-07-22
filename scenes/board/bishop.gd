class_name Bishop
extends Piece


func get_valid_tiles(start_position: Vector2i) -> Array[Vector2i]:
	var possible_moves_unvalidated := [
		Vector2i(1, 1),
		Vector2i(1, -1),
		Vector2i(-1, 1),
		Vector2i(-1, -1),
	]
	var valid_moves: Array[Vector2i]
	for axis: Vector2i in possible_moves_unvalidated:
		valid_moves = valid_moves + _validate_cells_in_line(
			start_position,
			axis,
		)
	print(valid_moves)
	return valid_moves
