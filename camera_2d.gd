extends Camera2D

@export var target: Node2D

func _physics_process(_delta: float) -> void:
	if target:
		global_position = global_position.lerp(target.global_position, 0.1)
