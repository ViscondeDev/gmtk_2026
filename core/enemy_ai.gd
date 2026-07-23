@icon("res://addons/at-icons/node3d/skull.svg")
class_name EnemyAI
extends Node

var pawn_position: Vector2i
var enemy_pices: Dictionary[Vector2i, Piece]
var possible_movements: Dictionary[Vector2i, Array]


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

		possible_movements[coord] = piece.movement_type.get_valid_tiles()


func attempt_take() -> bool:
	for enemy_coord in possible_movements:
		if pawn_position in possible_movements[enemy_coord]:
			enemy_pices[enemy_coord].move_to_tile(pawn_position)
			return true
	return false


