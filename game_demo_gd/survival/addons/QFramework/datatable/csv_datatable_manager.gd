extends DatatableManager
class_name CSVDatatableManager

func get_datatable(datatable_name : String) -> Dictionary:
	if _datatable_dics.has(datatable_name):
		return _datatable_dics[datatable_name]
	else:
		load_datatable(datatable_name, _datatable_path)
		return _datatable_dics[datatable_name]		

func load_datatable(name : String, path : String) :
	var file = File.new()
	file.open(path + name + ".csv", File.READ)
	var row_data = file.get_csv_line(",")
	var data_name = row_data
	
	var dic_dt = {}
	while not file.eof_reached():
		row_data = file.get_csv_line(",")
		var d = {}
		for i in row_data.size():
			d[data_name[i]] = row_data[i]
		dic_dt[d["ID"]] = d
	_datatable_dics[name] = dic_dt
