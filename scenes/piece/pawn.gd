@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Pawn
extends Piece


func _process(_delta: float) -> void:
	if TurnManager.current == null:
		return
	if TurnManager.current.current_state == TurnManager.State.SELECTION:
		for piece: StringName in pieces:
			if Input.is_action_just_pressed(piece):
				possible_moves = pieces[piece].movement_type.get_valid_tiles(current_board_position)
				TurnManager.current.current_state = TurnManager.State.MOVEMENT


func watch_game_state(state: TurnManager.State) -> void:
	match state:
		TurnManager.State.MOVEMENT:
			Board.current_board.cell_clicked.connect(move_to_tile)
		TurnManager.State.SELECTION:
			Board.current_board.cell_clicked.disconnect(move_to_tile)
