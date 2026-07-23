extends Control

enum LevelAction {
	BACK = 0,
}
signal level_select_action(action: LevelAction)

func _on_back_pressed() -> void:
	level_select_action.emit(LevelAction.BACK)
