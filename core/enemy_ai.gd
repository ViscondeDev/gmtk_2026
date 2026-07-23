@icon("res://addons/at-icons/node3d/skull.svg")
class_name EnemyAI
extends Node

var pawn_position: Vector2i
var enemy_pices: Dictionary[Vector2i, Piece]


func watch_state(state: Level.State) -> void:
	if state == Level.State.ENEMY:
		decide_moves()


func decide_moves() -> void:
	map_pieces_and_movements()
	if attempt_take():
		return
	if attempt_deffend():
		return


func map_pieces_and_movements() -> void:
	enemy_pices.clear()
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


func attempt_take() -> bool:
	for piece in enemy_pices.values():
		if pawn_position in piece.possible_moves:
			piece.move_to_tile(pawn_position)
			return true
	return false


func attempt_deffend() -> bool:
	var reachable_tiles: Dictionary[Vector2i, Array]
	var best_cell: Vector2i = Board.NULL_CELL
	for piece in enemy_pices.values():
		for tile: Vector2i in piece.possible_moves:
			if not reachable_tiles.has(tile):
				reachable_tiles[tile] = []
			reachable_tiles[tile].append(piece)

			if (
				best_cell == Board.NULL_CELL
				or reachable_tiles[tile].size() > reachable_tiles[best_cell].size()
			):
				best_cell = tile
	if best_cell != Board.NULL_CELL:
		reachable_tiles[best_cell][0].move_to_tile(best_cell)
		return true

	return false
