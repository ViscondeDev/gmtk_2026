extends Node

signal quit()
signal update_level(level: int)


enum Selection {
	KNIGHT = 0,
	BISHOP = 1,
	ROOK = 2,
}
enum SelectionState {
	SELECTED = 1,
	NONE = 2,
}
enum GameState {
	LOADING = 0,
	SELECTION = 1,
	MOVEMENT = 2,
	ENEMY = 3,
	WON = 4,
	LOST = 5,
}


const loading_scene = preload("res://scenes/ui scenes/Loading.tscn")
@export var level: int = 0
@onready var loadscreen_instance = loading_scene.instantiate()
@onready var power_selections: Array[Button] = [
	%Knight,
	%Bishop,
	%Rook,
]
@onready var selection_states: Array[SelectionState] = [
	SelectionState.NONE,
	SelectionState.NONE,
	SelectionState.NONE,
]

var loaded_scene: PackedScene = null
var current_instance: Node = null


func _ready() -> void:
	_load_level(level)
	
	for i in range(len(power_selections)):
		match selection_states[i]:
			SelectionState.SELECTED:
				power_selections[i].disabled = false
			_:
				power_selections[i].disabled = true


func _load_level(to_load: int):
	if to_load > 1:
		quit.emit()

	if current_instance != null:
		current_instance.queue_free()
	add_child(loadscreen_instance)
	
	match to_load:
		1:
			loaded_scene = load("res://scenes/levels/level.tscn")

	current_instance = loaded_scene.instantiate()
	current_instance.state_changed.connect(_update_state)
	current_instance.update_selection.connect(_update_selection)

	remove_child(loadscreen_instance)
	add_child(current_instance)


func _update_state(new_state: GameState):
	match new_state:
		GameState.WON:
			update_level.emit(level + 1)
		GameState.LOST:
			_load_level(level)


func _update_selection(selection: Selection, state: SelectionState):
	selection_states[selection] = state

	for i in range(len(power_selections)):
		match selection_states[i]:
			SelectionState.SELECTED:
				power_selections[i].disabled = false
			_:
				power_selections[i].disabled = true

func _on_pause_pressed() -> void:
	get_tree().paused = true
	$UI/PauseScreen.show()


func _on_pause_screen_quit() -> void:
	quit.emit()


func _on_pause_screen_restart() -> void:
	_load_level(level)
