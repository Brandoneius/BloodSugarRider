extends Node2D

@onready var track := $Track
@onready var rider := $Rider
@onready var load_button := $CanvasLayer/Button
@onready var file_dialog := $CanvasLayer/FileDialog
@onready var boost_label := $CanvasLayer/BoostLabel

func _ready() -> void:
	load_button.pressed.connect(_on_load_button_pressed)
	file_dialog.file_selected.connect(_on_file_selected)
	rider.freeze = true          # <-- NEW: don't let it fall yet
	rider.boost_charges_changed.connect(_on_boost_charges_changed)
	boost_label.text = "Gummies: %d" % rider.boost_charges
	boost_label.visible = false
	
func _on_load_button_pressed() -> void:
	file_dialog.popup()

func _on_file_selected(path: String) -> void:
	var readings := CSVLoader.load_dexcom_csv(path)
	if readings.is_empty():
		push_warning("No readings found in that file.")
		return
	track.build_from_data(readings)
	rider.global_position = track.points[2] + Vector2(0, -60)
	rider.linear_velocity = Vector2.ZERO
	rider.freeze = false         # <-- NEW: now let it go
	load_button.visible = false
	boost_label.visible = true

	
func _on_boost_charges_changed(charges: int) -> void:
	boost_label.text = "Gummies: %d" % charges
