extends Area2D
class_name GummyBag

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is Rider:
		body.add_boost_charge()
		queue_free()
