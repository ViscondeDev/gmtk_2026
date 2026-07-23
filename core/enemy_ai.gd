@icon("res://addons/at-icons/node3d/skull.svg")
class_name EnemyAI
extends Node

var pawn_position: Vector2i
var enemy_pices: Dictionary[Vector2i, Piece]
var possible_moves: Dictionary[Vector2i, PossibleCellStats]


func watch_state(state: TurnManager.State) -> void:
	if state == TurnManager.State.ENEMY:
		decide_moves()


func decide_moves() -> void:
	map_pieces_and_movements()
	if attempt_take(): return


func map_pieces_and_movements() -> void:
	for coord in Board.current_board.pieces:
		var piece := Board.current_board.pieces[coord]
		if piece.is_friendly:
			pawn_position = coord
		else:
			enemy_pices[coord] = piece

		var piece_moves :Array[Vector2i] = enemy_pices[coord].movement_type.get_script().get_valid_tiles(
			coord,
			false,
		)

		for tile in piece_moves:
			if not possible_moves.has(tile):
				var cell = PossibleCellStats.new()
				possible_moves[tile] = cell
			possible_moves[tile].reachable_from.append(coord)

func attempt_take() -> bool:
	if pawn_position in possible_moves.keys():
		var enemy_position = possible_moves[pawn_position].reachable_from[0]
		enemy_pices[enemy_position].move_to_tile(pawn_position)
		return true
	return false

class PossibleCellStats:
	var reachable_from: Array[Vector2i]
