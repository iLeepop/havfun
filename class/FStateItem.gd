class_name FStateItem
extends Node

var player = null

func _ready() -> void:
	await owner.ready
	player = get_parent().get_parent()

func enter_condition() -> bool:
	return true

func exit_condition() -> bool:
	return false

func on_enter():
	pass

func on_exit():
	pass

func update(delta):
	pass
