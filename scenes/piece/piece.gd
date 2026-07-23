@icon("res://addons/at-icons/node2d/chess_pawn.svg")
class_name Piece
extends Node2D

@export var movement_type: Movement
var current_board_position: Vector2i
var possible_moves: Array[Vector2i]
var pieces := {
	"rook": Rook,
	"bishop": Bishop,
	"knight": Knight,
}


func _ready():
	current_board_position = Board.current_board.local_to_map(global_position)


func move_to_tile(tile: Vector2i) -> void:
	if tile in possible_moves:
		position = Board.current_board.map_to_local(tile)
		current_board_position = tile
		TurnManager.current.current_state = TurnManager.State.SELECTION
	else:
		push_warning(name, " tried to move to invalid tile.")
