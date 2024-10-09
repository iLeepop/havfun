extends FStateItem

@onready var animation_player = $"../../AnimationPlayer"
@onready var sprite_2d = $"../../Sprite2D"

const SPEED = 100.0

func _ready() -> void:
	await owner.ready
	player = get_parent().get_parent()

func enter_condition() -> bool:
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	var is_still = is_zero_approx(x_direction) and is_zero_approx(y_direction)
	return not is_still

func exit_condition() -> bool:
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	var is_still = is_zero_approx(x_direction) and is_zero_approx(y_direction)
	return is_still

func on_enter():
	pass

func on_exit():
	pass

func update(delta):
	animation_player.play("move")
	move(delta)

func move(_delta):
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	if x_direction or y_direction:
		player.velocity.x = x_direction * SPEED
		player.velocity.y = y_direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.y = move_toward(player.velocity.y, 0, SPEED)
	
	if not is_zero_approx(x_direction):
		sprite_2d.flip_h = x_direction < 0

	player.move_and_slide()
