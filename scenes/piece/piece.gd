@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Piece
extends Node2D

@export var movement_type: Movement
@export var is_friendly: bool = false

var current_board_position: Vector2i
var possible_moves: Array[Vector2i]


func _ready():
	current_board_position = Board.current_board.local_to_map(global_position)
	Board.current_board.pieces[current_board_position] = self


func move_to_tile(tile: Vector2i) -> void:
	if tile in possible_moves:
		if (
			tile in Board.current_board.pieces.keys()
			and Board.current_board.pieces[tile].is_friendly != is_friendly
		):
			Board.current_board.pieces[tile].queue_free()
		position = Board.current_board.map_to_local(tile)
		current_board_position = tile
		TurnManager.current.current_state = TurnManager.State.SELECTION
	else:
		push_warning(name, " tried to move to invalid tile.")
