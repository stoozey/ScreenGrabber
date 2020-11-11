var _debugSettings = true;

var _hasParam = ((_debugSettings) ? 2 : parameter_count());
if (_hasParam == 2)
{
	var _param = ((_debugSettings) ? "rm_settings" : parameter_string(1));
	var _room = asset_get_index(_param);
	
	var _width, _height;
	switch (_param)
	{
		default: _width = 1; _height = 1; break;
		
		case "rm_settings": _width = ROOM_SETTINGS_WIDTH; _height = ROOM_SETTINGS_HEIGHT; window_set_caption("ScreenGrabber - Settings"); break;
	}
	
	window_set_size(_width, _height);
	room_goto(_room);
	
	exit;
}

window_set_caption("ScreenGrabber - Grab Client");
room_goto(rm_grab_client);