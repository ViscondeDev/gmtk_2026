@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Pawn
extends Piece

var movement_keys := {
	"rook": Rook.new(),
	"bishop": Bishop.new(),
	"knight": Knight.new(),
}
var selection_type := {
	"rook": Selection.ROOK,
	"bishop": Selection.BISHOP,
	"knight": Selection.KNIGHT,
}

enum Selection {
	KNIGHT = 0,
	BISHOP = 1,
	ROOK = 2,
}
enum SelectionState {
	SELECTED = 1,
	NONE = 2,
}

func _process(_delta: float) -> void:
	if Level.current == null:
		return
	if Level.current.current_state == Level.State.SELECTION:
		Board.effects_layer.clear()
		for key: StringName in movement_keys:
			Level.current.update_selection.emit(selection_type[key], SelectionState.NONE)
			if Input.is_action_just_pressed(key):
				possible_moves = movement_keys[key].get_valid_tiles(
					current_board_position,
					is_friendly,
				)
				Board.effects_layer.highlight_tiles(
					possible_moves,
					Board.effects_layer.Effect.AVALIABLE,
				)
				Level.current.current_state = Level.State.MOVEMENT
				Level.current.update_selection.emit(selection_type[key], SelectionState.SELECTED)

func watch_game_state(state: Level.State) -> void:
	match state:
		Level.State.MOVEMENT:
			Board.current_board.cell_clicked.connect(move_to_tile)
		Level.State.SELECTION:
			if Board.current_board.cell_clicked.is_connected(move_to_tile):
				Board.current_board.cell_clicked.disconnect(move_to_tile)
