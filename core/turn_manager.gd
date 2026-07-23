@icon("res://addons/at-icons/node/arrows_clockwise.svg")
class_name TurnManager
extends Node

signal state_changed(new_state: State)

enum State {
	SELECTION,
	MOVEMENT,
	ENEMY,
}
static var current: TurnManager

var current_state: State:
	set(s):
		current_state = s
		state_changed.emit(current_state)


func _ready() -> void:
	current = self
	current_state = State.SELECTION
