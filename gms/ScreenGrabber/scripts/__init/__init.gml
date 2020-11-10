globalvar config;
config =
{
	after_screenshot:
	{
		skip_dialog_menu: DialogAction.Null, // if this is set to an action, it will auto-perform it without using the dialogm menu
		copy_to_clipboard: true,
	},
	
	visual:
	{
		fancy_drag_box: true,
		favourite_colour: { h: 110, s: 190, l: 187 },
	},
	
	debug: true,
};
		
switch (file_exists(FILE_CONFIG))
{
	case true:
	{
		print("loading save");
		var _file = file_text_open_read(FILE_CONFIG);
			var _json = file_text_read_string(_file);
		file_text_close(_file);
		
		// this makes sure that we dont crash because things were missing
		var _savedConfig = snap_from_json(_json);
		var _configKeys = variable_struct_get_names(_savedConfig);
		for (var i = 0; i < variable_struct_names_count(_savedConfig); i++)
		{
			var _key = _configKeys[i];
			if (!variable_struct_exists(config, _key)) continue;
			
			variable_struct_set(config, _key, variable_struct_get(_savedConfig, _key));
		}
	} break;
	
	case false:
	{
		var _json = snap_to_json(config);
		var _file = file_text_open_write(FILE_CONFIG);
			file_text_write_string(_file, _json);
		file_text_close(_file);
		
		delete _json;
		
		print(FILE_CONFIG);
	} break;
}


var h = config.visual.favourite_colour.h, s = config.visual.favourite_colour.s, l = config.visual.favourite_colour.l;
var _baseColour = make_colour_hsv(h, s, l);//HslToHsv(h, s, l);
globalvar favColour;
favColour =
{
	full: _baseColour,
	
	dark:		merge_colour(_baseColour,	c_black, 0.2),
	darker:		merge_colour(_baseColour,	c_black, 0.4),
	darkest:	merge_colour(_baseColour,	c_black, 0.8),
	
	background:			make_colour_rgb(45, 47, 62),
	background_dark:	make_colour_rgb(40, 42, 54),
	background_darker:	make_colour_rgb(33, 34, 44),
};

function SaveConfig()
{
	var _json = snap_to_json(config);
	var _file = file_text_open_write(FILE_CONFIG);
		file_text_write_string(_file, _json);
	file_text_close(_file);
}

function FunctionNull() { };
