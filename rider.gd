extends RigidBody2D
class_name Rider

#Signals to emit events called by other nodes
signal fell_off
signal boosted(amount:float)

var death_y: float = 2000.0
var max_distance_x: float = 0.0

# _ready function is called when the node is first instanced 
func _ready()-> void:
	gravity_scale = 1.1
	
func _physics_process(delta: float) -> void:
	max_distance_x = max(max_distance_x, global_position.x)
	#print(global_position.x)
	
	if global_position.y > death_y:
		fell_off.emit()
	
func apply_boost(direction: Vector2, force: float) -> void:
	linear_velocity += direction.normalized() * force
	boosted.emit(force)
