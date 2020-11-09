var _hasParam = (parameter_count > 0);
//_hasParam = false;
if (_hasParam)
{
	var _param = parameter_string(0);
	//_param = "rm_settings"
	var _room = asset_get_index(_param);
	
	var _width, _height;
	switch (_param)
	{
		default: _width = 1; _height = 1; break;
		
		case "rm_settings": _width = ROOM_SETTINGS_WIDTH; _height = ROOM_SETTINGS_HEIGHT; break;
	}
	
	window_set_size(_width, _height);
	room_goto(_room);
	
	exit;
}

room_goto(rm_grab_client);