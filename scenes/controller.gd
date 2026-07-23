extends Node

const loading_scene = preload("res://scenes/ui scenes/Loading.tscn")
var current_scene : PackedScene = null
var current_instance: Node = null

@onready var loadscreen_instance = loading_scene.instantiate()

func _ready() -> void:
	_transition_scene(SceneType.MAIN)
	
	
enum MainSceneAction {
	START = 0,
	LEVEL_SELECT = 1,
	CREDITS = 2
}
func _main_scene_action(type: MainSceneAction):
	match type:
		MainSceneAction.START:
			print("Game not created yet")
		MainSceneAction.LEVEL_SELECT:
			_transition_scene(SceneType.LEVEL_SELECT)
		MainSceneAction.CREDITS:
			print("Credits not created yet")


enum LevelActionAction {
	BACK = 0,
	LEVEL_SELECT = 1,
}
func _level_select_action(type: LevelActionAction, extra):
	match type:
		LevelActionAction.BACK:
			_transition_scene(SceneType.MAIN)
		LevelActionAction.LEVEL_SELECT:
			print("Levels not added yet")
			#_load_level(extra)
	
	
enum SceneType {
	MAIN,
	LEVEL_SELECT,
	GAME,
}
func _transition_scene(to: SceneType, level: int = 0):
	remove_child(current_instance)
	add_child(loadscreen_instance)
	
	match to:
		SceneType.MAIN:
			current_scene = load("res://scenes/ui scenes/main_screen/MainScreen.tscn")
			current_instance = current_scene.instantiate()
			current_instance.main_screen_action.connect(_main_scene_action)
			
		SceneType.LEVEL_SELECT:
			current_scene = load("res://scenes/ui scenes/level_select/level_select.tscn")
			current_instance = current_scene.instantiate()
			current_instance.level_select_action.connect(_level_select_action)
		
		SceneType.GAME:
			current_scene = load("res://scenes/ui scenes/board/board.tscn")
			current_instance = current_scene.instantiate()
			current_instance.level = level

	remove_child(loadscreen_instance)
	add_child(current_instance)
