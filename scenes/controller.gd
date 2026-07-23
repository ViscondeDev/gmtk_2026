extends Node

const loading_scene = preload("res://scenes/Loading.tscn")
var current_scene = load("res://scenes/main_screen/MainScreen.tscn")
var current_instance: Node = null

@onready var loadscreen_instance = loading_scene.instantiate()

func _ready() -> void:
	current_instance = current_scene.instantiate()
	add_child(current_instance)
	current_instance.main_screen_action.connect(_main_scene_action)
	
	
enum MainSceneAction {
	START = 0,
	LEVEL_SELECT = 1,
	CREDITS = 2
}
func _main_scene_action(type: MainSceneAction):
	remove_child(current_instance)
	add_child(loadscreen_instance)
	
	match type:
		MainSceneAction.START:
			_load_game(1)
		MainSceneAction.LEVEL_SELECT:
			_load_level_select()
		MainSceneAction.CREDITS:
			_load_credits()


func _load_game(_level: int):
	print("Game not created yet")
	remove_child(loadscreen_instance)
	add_child(current_instance)


func _load_level_select():
	print("Level not created yet")
	remove_child(loadscreen_instance)
	add_child(current_instance)


func _load_credits():
	print("Credits not created yet")
	remove_child(loadscreen_instance)
	add_child(current_instance)
