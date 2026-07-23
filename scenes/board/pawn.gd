@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Pawn
extends Piece

var pieces := {
	"rook": Rook,
	"bishop": Bishop,
	"knight": Knight,
}
var possible_moves: Array[Vector2i]


func _ready() -> void:
	current_board_position = Board.current_board.local_to_map(global_position)


func _process(_delta: float) -> void:
	if TurnManager.current == null:
		return
	if TurnManager.current.current_state == TurnManager.State.SELECTION:
		for piece: StringName in pieces:
			if Input.is_action_just_pressed(piece):
				possible_moves = pieces[piece].get_valid_tiles(current_board_position)
				TurnManager.current.current_state = TurnManager.State.MOVEMENT


func watch_game_state(state: TurnManager.State) -> void:
	match state:
		TurnManager.State.MOVEMENT:
			Board.current_board.cell_clicked.connect(recieve_click)
		TurnManager.State.SELECTION:
			Board.current_board.cell_clicked.disconnect(recieve_click)


func recieve_click(tile: Vector2i) -> void:
	if tile in possible_moves:
		position = Board.current_board.map_to_local(tile)
		current_board_position = tile
		TurnManager.current.current_state = TurnManager.State.SELECTION
	else:
		print("ignore")
