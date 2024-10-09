class_name FStateMachine
extends Node

@export var default_state := "NONE"

var current_state = null

func _ready():
	await owner.ready
	set_initial_state()


func _physics_process(delta):
	if current_state:
		current_state.update(delta)
		check_state_transitions()
	else:
		push_error("当前状态丢失")

func set_initial_state():
	current_state = get_node_or_null(default_state)
	if current_state:
		current_state.on_enter()
	else:
		push_error("初始化状态失败: " + default_state)
	

func check_state_transitions():
	for state in get_children():
		if state != current_state:
			if state.enter_condition():
				print_debug("即将进入" + state.name + "状态")
				if current_state.exit_condition():
					print_debug("退出" + current_state.name + "状态")
					current_state.on_exit()
					current_state = state
					current_state.on_enter()
					print_debug("进入" + current_state.name + "状态")
					break

