@icon("res://addons/at-icons/animation/arrow_cross.svg")
class_name PieceMovement
extends AnimationPlayer

signal movement_finished

@export_category("movement")
@export var body: Piece
@export var movement_curve: Curve
@export var tilt_curve: Curve
@export var movement_duration: float = 0.6
var point_in_curve: float
var is_moving: bool = false
var go_from: Vector2
var go_to: Vector2


func _process(delta: float) -> void:
	if is_moving:
		_perform_movement()
		if point_in_curve < 1:
			point_in_curve += delta / movement_duration
		else:
			point_in_curve = 0
			is_moving = false
			movement_finished.emit()


func queue_movement(from: Vector2, to: Vector2) -> void:
	point_in_curve = 0
	go_from = from
	go_to = to
	is_moving = true


func _perform_movement():
	body.global_position = lerp(go_from, go_to, movement_curve.sample(point_in_curve))
	if go_from.x > go_to.x:
		body.rotation = tilt_curve.sample(point_in_curve)
	elif go_from.x < go_to.x:
		body.rotation = tilt_curve.sample(point_in_curve) * -1
