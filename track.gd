extends Node2D

var points := PackedVector2Array()

func build_from_data(readings: Array) -> void:
	points.clear()
	var smoothed := _smooth_readings(readings, 5)
	var x := 0.0
	for glucose in smoothed:
		var y = -(glucose - 120.0) * 5
		points.append(Vector2(x, y))
		x += 40.0

	var line := Line2D.new()
	line.points = points
	line.width = 10.0
	line.default_color = Color(0,0,0)
	add_child(line)

	var collider := $StaticBody2D/CollisionPolygon2D
	collider.build_mode = CollisionPolygon2D.BUILD_SOLIDS
	var solid_points := points.duplicate()
	solid_points.append(Vector2(points[points.size() - 1].x, 5000.0))
	solid_points.append(Vector2(points[0].x, 5000.0))
	collider.polygon = solid_points

func _smooth_readings(readings: Array, radius: int) -> Array:
	var smoothed: Array = []
	for i in readings.size():
		var total := 0.0
		var count := 0
		for offset in range(-radius, radius + 1):
			var idx = i + offset
			if idx >= 0 and idx < readings.size():
				total += readings[idx]["value"]
				count += 1
		smoothed.append(total / count)
	return smoothed
