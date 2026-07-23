extends Control

enum LevelAction {
	BACK = 0,
	LEVEL_SELECT = 1,
}
signal level_select_action(action: LevelAction, extra)

func _on_back_pressed() -> void:
	level_select_action.emit(LevelAction.BACK, 0)


func _on_level_select(level: int) -> void:
	level_select_action.emit(LevelAction.LEVEL_SELECT, level)
