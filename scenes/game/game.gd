extends Node

"""
Expected methods and signals from levels
```
signal win()
signal lose()
```
"""

signal quit()
signal update_level(level: int)

const loading_scene = preload("res://scenes/ui scenes/Loading.tscn")
@onready var loadscreen_instance = loading_scene.instantiate()
@export var level: int = 0

var loaded_scene: PackedScene = null
var current_instance: Node = null


func _ready() -> void:
	_load_level(level)
	
	# TODO: Remove these two lines when game is actually there.
	# This is just for testing to be sure everything works, the levels
	# themselves are supposed to signal win to update levels
	await get_tree().create_timer(3).timeout
	update_level.emit(level + 1)


func _load_level(level: int):
	if true: # TODO: Remove this block when levels exist
		return

	if current_instance != null:
		current_instance.queue_free()
	add_child(loadscreen_instance)
	
	match level:
		# TODO: Add other levels here and remove 0
		0:
			loaded_scene = load("res://path/to/level0.tscn")

	current_instance = loaded_scene.instantiate()
	current_instance.win.connect(_win_signal)
	current_instance.lose.connect(_lose_signal)

	remove_child(loadscreen_instance)
	add_child(current_instance)


func _win_signal():
	update_level.emit(level + 1)


func _lose_signal():
	quit.emit()


func _on_pause_pressed() -> void:
	get_tree().paused = true
	$UI/PauseScreen.show()


func _on_pause_screen_quit() -> void:
	quit.emit()


func _on_pause_screen_restart() -> void:
	_load_level(level)
