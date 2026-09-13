extends Node2D

#This is cool, name a variable like this to add an inspector field 
@export var gummy_bag_scene: PackedScene
@export var min_gap: float = 300.0
@export var max_gap: float = 900.0
@export var height_above_track: float = 40.0

func spawn_along_track(track_points: PackedVector2Array) -> void:
	for child in get_children():
		child.queue_free()

	if gummy_bag_scene == null:
		push_error("GummySpawner has no gummy_bag_scene assigned")
		return

	var next_x := randf_range(min_gap, max_gap)
	for p in track_points:
		if p.x >= next_x:
			var bag: GummyBag = gummy_bag_scene.instantiate()
			bag.position = Vector2(p.x, p.y - height_above_track)
			add_child(bag)
			next_x += randf_range(min_gap, max_gap)
