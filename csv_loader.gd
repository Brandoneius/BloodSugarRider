extends Node

func load_dexcom_csv(path: String) -> Array:
	var readings: Array = []
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Could not open CSV: %s" % path)
		return readings

	var header := file.get_csv_line()
	var glucose_col := -1
	var type_col := -1

	for i in header.size():
		var col_name := header[i].strip_edges().to_lower()
		if col_name.find("glucose value") != -1:
			glucose_col = i
		if col_name.find("event type") != -1:
			type_col = i

	if glucose_col == -1:
		push_error("Couldn't find a 'Glucose Value' column in this CSV.")
		return readings

	while not file.eof_reached():
		var row := file.get_csv_line()
		if row.size() <= glucose_col:
			continue
		if type_col != -1 and row[type_col].strip_edges() != "EGV":
			continue

		var raw_value := row[glucose_col].strip_edges()
		if raw_value.is_valid_float():
			readings.append({"value": raw_value.to_float()})

	file.close()
	return readings
