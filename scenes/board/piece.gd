@abstract class_name Piece
extends Node2D

var current_board_position: Vector2i


@abstract
func get_valid_tiles(start_position: Vector2i) -> Array[Vector2i]

func _validate_cells_in_line(start_position: Vector2i, axis: Vector2i) -> Array[Vector2i]:
	var possible_valid_moves: Array[Vector2i]
	var next_tile := start_position + axis
	if next_tile in Board.current_board.tiles:
		possible_valid_moves.append(next_tile)
		possible_valid_moves = possible_valid_moves + _validate_cells_in_line(next_tile, axis)
	return possible_valid_moves