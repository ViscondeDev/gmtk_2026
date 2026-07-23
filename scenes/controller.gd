extends Node

const loading_scene = preload("res://scenes/ui scenes/Loading.tscn")
var current_scene = load("res://scenes/ui scenes/main_screen/MainScreen.tscn")
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
	current_scene = load("res://scenes/ui scenes/level_select/level_select.tscn")
	current_instance = current_scene.instantiate()
	current_instance.level_select_action.connect(_level_select_action)
	remove_child(loadscreen_instance)
	add_child(current_instance)


func _load_credits():
	print("Credits not created yet")
	remove_child(loadscreen_instance)
	add_child(current_instance)

enum LevelActionAction {
	BACK = 0,
}
func _level_select_action(type: LevelActionAction):
	remove_child(current_instance)
	add_child(loadscreen_instance)
	
	match type:
		LevelActionAction.BACK:
			_back_to_main()
	
	
func _back_to_main():
	current_scene = load("res://scenes/ui scenes/main_screen/MainScreen.tscn")
	current_instance = current_scene.instantiate()
	current_instance.main_screen_action.connect(_main_scene_action)
	remove_child(loadscreen_instance)
	add_child(current_instance)
