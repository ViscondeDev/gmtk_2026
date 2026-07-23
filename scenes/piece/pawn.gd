@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Pawn
extends Piece

var movement_keys := {
	"rook": Rook.new(),
	"bishop": Bishop.new(),
	"knight": Knight.new(),
}


func _process(_delta: float) -> void:
	if TurnManager.current == null:
		return
	if TurnManager.current.current_state == TurnManager.State.SELECTION:
		for key: StringName in movement_keys:
			if Input.is_action_just_pressed(key):
				possible_moves = movement_keys[key].get_valid_tiles(current_board_position)
				TurnManager.current.current_state = TurnManager.State.MOVEMENT


func watch_game_state(state: TurnManager.State) -> void:
	match state:
		TurnManager.State.MOVEMENT:
			Board.current_board.cell_clicked.connect(move_to_tile)
		TurnManager.State.SELECTION:
			Board.current_board.cell_clicked.disconnect(move_to_tile)
