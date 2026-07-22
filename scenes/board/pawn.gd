@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Pawn
extends Piece

func _ready() -> void:
	current_board_position = Board.current_board.local_to_map(global_position)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("rook"):
		Rook.get_valid_tiles(current_board_position)
	if Input.is_action_just_pressed("bishop"):
		Bishop.get_valid_tiles(current_board_position)
	if Input.is_action_just_pressed("knight"):
		Knight.get_valid_tiles(current_board_position)
