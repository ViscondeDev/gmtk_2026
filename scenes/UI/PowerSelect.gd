extends Control

enum PowerType {
	KNIGHT,
	BISHOP,
	ROOK
}
signal power_select(type: PowerType)

func _knight_select() -> void:
	power_select.emit(PowerType.KNIGHT)

func _bishop_select() -> void:
	power_select.emit(PowerType.BISHOP)

func _rook_select() -> void:
	power_select.emit(PowerType.ROOK)
