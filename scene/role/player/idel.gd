extends FStateItem

@onready var animation_player = $"../../AnimationPlayer"

func _ready() -> void:
	await owner.ready
	player = get_parent().get_parent()

func enter_condition() -> bool:
	return Input.is_action_pressed("move_down") || Input.is_action_pressed("move_up") || Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right")

func exit_condition() -> bool:
	return true

func on_enter():
	pass

func on_exit():
	pass

func update(delta):
	animation_player.play("RESET")
