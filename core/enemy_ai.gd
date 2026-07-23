@icon("res://addons/at-icons/node3d/skull.svg")
class_name EnemyAI
extends Node

var pawn_position: Vector2i
var enemy_pices: Dictionary[Vector2i, Piece]


func watch_state(state: TurnManager.State) -> void:
	if state == TurnManager.State.ENEMY:
		decide_moves()


func decide_moves() -> void:
	map_pieces_and_movements()
	if attempt_take():
		return


func map_pieces_and_movements() -> void:
	for coord in Board.current_board.pieces:
		var piece := Board.current_board.pieces[coord]
		if piece.is_friendly:
			pawn_position = coord
		else:
			enemy_pices[coord] = piece
			piece.possible_moves = piece.movement_type.get_valid_tiles(
				piece.current_board_position,
				piece.is_friendly,
			)
			print(piece.possible_moves)


func attempt_take() -> bool:
	print(pawn_position)
	for piece in enemy_pices.values():
		if pawn_position in piece.possible_moves:
			print("taking")
			piece.move_to_tile(pawn_position)
			return true
	return false
