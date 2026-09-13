extends RigidBody2D
class_name Rider

signal fell_off
signal boosted(amount: float)
signal boost_charges_changed(charges: int)

var death_y: float = 2000.0
var max_distance_x: float = 0.0
var boost_charges: int = 50
var boost_force: float = 500.0

func _ready() -> void:
	gravity_scale = 0.8

func _physics_process(_delta: float) -> void:
	max_distance_x = max(max_distance_x, global_position.x)
	if global_position.y > death_y:
		fell_off.emit()

func apply_boost(direction: Vector2, force: float) -> void:
	linear_velocity += direction.normalized() * force
	boosted.emit(force)

func try_player_boost(direction: Vector2) -> void:
	if boost_charges <= 0:
		return
	boost_charges -= 1
	boost_charges_changed.emit(boost_charges)
	apply_boost(direction, boost_force)
	
func add_boost_charge() -> void:
	boost_charges += 1
	boost_charges_changed.emit(boost_charges)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("boost_up"):
		try_player_boost(Vector2.UP)
	elif event.is_action_pressed("boost_down"):
		try_player_boost(Vector2.DOWN)
	elif event.is_action_pressed("boost_left"):
		try_player_boost(Vector2.LEFT)
	elif event.is_action_pressed("boost_right"):
		try_player_boost(Vector2.RIGHT)
