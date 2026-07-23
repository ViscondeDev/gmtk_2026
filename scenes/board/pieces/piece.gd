@abstract class_name Piece
extends Node2D

var current_board_position: Vector2i
var possible_moves: Array[Vector2i]
var pieces := {
	"rook": Rook,
	"bishop": Bishop,
	"knight": Knight,
}


static func get_valid_tiles(_start_position: Vector2i) -> Array[Vector2i]:
	printerr("CALLED get_valid_tiles in abstract class Pieces")
	return []


static func _validate_cells_in_line(start_position: Vector2i, axis: Vector2i) -> Array[Vector2i]:
	var valid_moves: Array[Vector2i]
	var next_tile := start_position + axis
	if next_tile in Board.current_board.tiles:
		valid_moves.append(next_tile)
		valid_moves = valid_moves + _validate_cells_in_line(next_tile, axis)
	return valid_moves


func move_to_tile(tile: Vector2i) -> void:
	if tile in possible_moves:
		position = Board.current_board.map_to_local(tile)
		current_board_position = tile
		TurnManager.current.current_state = TurnManager.State.SELECTION
	else:
		push_warning(name, " tried to move to invalid tile.")
