extends Node2D

var points := PackedVector2Array()

func build_from_data(readings: Array) -> void:
	points.clear()
	var x := 0.0
	for reading in readings:
		var glucose: float = reading["value"]
		var y := -(glucose - 120.0) * 5
		points.append(Vector2(x, y))
		x += 40.0

	var line := Line2D.new()
	line.points = points
	line.width = 6.0
	line.default_color = Color(0,0,0)
	add_child(line)

	var collider := $StaticBody2D/CollisionPolygon2D
	collider.build_mode = CollisionPolygon2D.BUILD_SOLIDS
	var solid_points := points.duplicate()
	solid_points.append(Vector2(points[points.size() - 1].x, 5000.0))
	solid_points.append(Vector2(points[0].x, 5000.0))
	collider.polygon = solid_points
