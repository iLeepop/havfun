class_name StateMechine
extends Node

# 父节点操作 current_state 时的具体方法
var current_state: int = -1:
	set(v):
		# 调用父节点的方法
		owner.transition_state(current_state, v)
		current_state = v

func _ready() -> void:
	# 等待父节点ready
	await owner.ready
	# 初始化 current_state
	current_state = 0

# 实例化该类的父节点无需提供 _physics_process 方法
func _physics_process(delta: float) -> void:
	while true:
		var next_current := owner.get_next_state(current_state) as int
		if current_state == next_current:
			break
		current_state = next_current
	
	# 调用父节点的方法，父节点无需实现 _physics_process方法
	owner.tick_physics(current_state, delta)
