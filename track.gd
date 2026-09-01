extends Node2D

func _ready() -> void:
	#the := will let GDscript auto assign the type of the variable
	var fake_readings := [100.0, 140.0, 90.0, 160.0, 110.0]
	
	var points := PackedVector2Array()
	var x := 0.0
	for glucose in fake_readings:
		var y = -(glucose - 120) * 1.5
		points.append(Vector2(x,y))
		x += 100

	var line := Line2D.new()
	line.points = points
	line.width = 6.0
	line.default_color = Color(0.071, 0.071, 0.071, 1.0)
	add_child(line)

	var collider := $StaticBody2D/CollisionPolygon2D
	collider.polygon = points
