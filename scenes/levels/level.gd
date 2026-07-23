@icon("res://addons/at-icons/node2d/globe.svg")
class_name Level
extends Node2D

signal state_changed(new_state: State)
signal game_ended()

enum State {
	LOADING,
	SELECTION,
	MOVEMENT,
	ENEMY,
	WON,
	LOST,
}
static var current: Level

@onready var pawn: Pawn = %Pawn
@onready var enemie_ai: EnemyAI = %EnemyAI

var current_state: State = State.LOADING:
	set(s):
		current_state = s
		state_changed.emit(current_state)


func _ready() -> void:
	current = self
	state_changed.connect(pawn.watch_game_state)
	state_changed.connect(enemie_ai.watch_state)
	current_state = State.SELECTION


func finish_turn() -> void:
	match current_state:
		State.MOVEMENT:
			current_state = State.ENEMY
		State.ENEMY:
			current_state = State.SELECTION


func end_game(state: State) -> void:
	current_state = state
	game_ended.emit()
