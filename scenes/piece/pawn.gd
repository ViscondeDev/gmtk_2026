@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Pawn
extends Piece

var movement_keys := {
	"rook": Rook.new(),
	"bishop": Bishop.new(),
	"knight": Knight.new(),
}


func _process(_delta: float) -> void:
	if Level.current == null:
		return
	if Level.current.current_state == Level.State.SELECTION:
		for key: StringName in movement_keys:
			if Input.is_action_just_pressed(key):
				possible_moves = movement_keys[key].get_valid_tiles(
					current_board_position,
					is_friendly,
				)
				Level.current.current_state = Level.State.MOVEMENT


func watch_game_state(state: Level.State) -> void:
	match state:
		Level.State.MOVEMENT:
			Board.current_board.cell_clicked.connect(move_to_tile)
		Level.State.SELECTION:
			if Board.current_board.cell_clicked.is_connected(move_to_tile):
				Board.current_board.cell_clicked.disconnect(move_to_tile)
