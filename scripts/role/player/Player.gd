extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

enum State {
	IDEL,
	MOVE
}

@export var default_state = State.IDEL

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func transition_state(current_state: State, next_state: State):
	match next_state:
		State.IDEL:
			animation_player.play("RESET")
		State.MOVE:
			animation_player.play("move")

func get_next_state(state: State) -> State:
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	var is_still = is_zero_approx(x_direction) and is_zero_approx(y_direction)
	match state:
		State.IDEL:
			if not is_still:
				return State.MOVE
		State.MOVE:
			if is_still:
				return State.IDEL
	
	return state
	
func tick_physics(state: State, delta: float):
	match state:
		State.IDEL:
			pass
		State.MOVE:
			move(delta)
	

func move(delta):
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	if x_direction or y_direction:
		velocity.x = x_direction * SPEED
		velocity.y = y_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if not is_zero_approx(x_direction):
		sprite_2d.flip_h = x_direction < 0

	move_and_slide()
	

