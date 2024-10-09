extends FStateItem

@onready var animation_player = $"../../AnimationPlayer"

func _ready() -> void:
	await owner.ready
	player = get_parent().get_parent()

func enter_condition() -> bool:
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	var is_still = is_zero_approx(x_direction) and is_zero_approx(y_direction)
	return is_still

func exit_condition() -> bool:
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	var is_still = is_zero_approx(x_direction) and is_zero_approx(y_direction)
	return not is_still	

func on_enter():
	pass

func on_exit():
	pass

func update(_delta):
	animation_player.play("RESET")
