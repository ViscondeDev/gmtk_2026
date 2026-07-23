@icon("res://addons/at-icons/node/arrow_cross.svg")
@abstract class_name Movement
extends Resource


static func _validate_cells_in_line(start_position: Vector2i, axis: Vector2i) -> Array[Vector2i]:
	var valid_moves: Array[Vector2i]
	var next_tile := start_position + axis
	if next_tile in Board.current_board.tiles:
		valid_moves.append(next_tile)
		valid_moves = valid_moves + _validate_cells_in_line(next_tile, axis)
	return valid_moves
