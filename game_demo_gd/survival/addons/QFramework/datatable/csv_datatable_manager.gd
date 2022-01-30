extends DatatableManager
class_name CSVDatatableManager

var thread := Thread.new()

func get_datatable(datatable_name : String) -> Dictionary:
	if _datatable_dics.has(datatable_name):
		return _datatable_dics[datatable_name]
	else:
		load_datatable(datatable_name, _datatable_path)
		return _datatable_dics[datatable_name]		

func load_datatables_async(datatables : Array) -> Array:
	var datatables_in = datatables.duplicate()
	var out := []
	if can_async:
		thread.start(self, 'threaded_load', datatables_in)
		out = yield(self, "done")
		thread.wait_to_finish()
	else:
		print("can not async load csv")
	return out
	
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

func threaded_load(datatables_in : Array) -> void:
	var datatables_out = []
	var file = File.new()
	for dat_in in datatables_in:
		file.open(dat_in, File.READ)
		var row_data = file.get_csv_line(",")
		var data_name = row_data
		
		var dic_dt = {}
		while not file.eof_reached():
			row_data = file.get_csv_line(",")
			var d = {}
			for i in row_data.size():
				d[data_name[i]] = row_data[i]
			dic_dt[d["ID"]] = d
		datatables_out.append(dic_dt)
	call_deferred('emit_signal', 'done', datatables_out)
