///@desc save config
var _json = snap_to_json(config);
var _file = file_text_open_write(FILE_CONFIG);
	file_text_write_string(_file, _json);
file_text_close(_file);