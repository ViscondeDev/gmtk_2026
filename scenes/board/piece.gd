@abstract class_name Piece
extends Node2D

var current_board_position: Vector2i


@abstract
func get_valid_tiles(start_position: Vector2i) -> Array[Vector2i]

func _validate_cells_in_line(start_position: Vector2i, axis: Vector2i) -> Array[Vector2i]:
	var valid_moves: Array[Vector2i]
	var next_tile := start_position + axis
	if next_tile in Board.current_board.tiles:
		valid_moves.append(next_tile)
		valid_moves = valid_moves + _validate_cells_in_line(next_tile, axis)
	return valid_moves