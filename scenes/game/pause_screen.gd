extends ColorRect

signal quit()
signal restart()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	hide()
	quit.emit()

func _on_restart_level_pressed() -> void:
	get_tree().paused = false
	hide()
	restart.emit()
