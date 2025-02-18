#macro FILE_POST_CALL_CONFIG (DIR_PROGRAM_DIRECOTRY + "post_call_config.ini")

function GetIni(_key, _default)
{
	ini_open(FILE_POST_CALL_CONFIG);
		var _value = ini_read_real("", _key, _default);
	ini_close();
	
	return _value;
}

function WriteIni(_key, _value)
{
	ini_open(FILE_POST_CALL_CONFIG);
		ini_write_real("", _key, _value);
	ini_close();
}


function UiButtonSaveClicked(_ui)
{
	UiTweenClicked(_ui);
	SaveConfig();
}

function UiButtonExitClicked()
{
	game_end();
}

function UiCheckboxFancySelectionInit(_ui)
{
	toggle = config.visual.fancy_drag_box;
}

function UiCheckboxFancySelectionClicked(_ui)
{
	UiCheckboxClicked(_ui);
	
	config.visual.fancy_drag_box = _ui.toggle;
}

function UiCheckboxDebugModeInit(_ui)
{
	toggle = config.debug;
}

function UiCheckboxDebugModeClicked(_ui)
{
	UiCheckboxClicked(_ui);
	
	config.debug = _ui.toggle;
}

function UiCheckboxAlwaysCopyToClipboardInit(_ui)
{
	toggle = config.after_screenshot.copy_to_clipboard;
}

function UiCheckboxAlwaysCopyToClipboardClicked(_ui)
{
	UiCheckboxClicked(_ui);
	
	config.after_screenshot.copy_to_clipboard = _ui.toggle;
}

function UiCheckboxShowDialogOptionsInit(_ui)
{
	toggle = config.after_screenshot.skip_dialog_menu;
}

function UiCheckboxShowDialogOptionsClicked(_ui)
{
	UiCheckboxClicked(_ui);
	
	config.after_screenshot.skip_dialog_menu = _ui.toggle;
}

function UiCheckboxShowSaveAsDialogInit(_ui)
{
	toggle = config.show_file_save_dialog;
}

function UiCheckboxShowSaveAsDialogClicked(_ui)
{
	UiCheckboxClicked(_ui);
	
	config.show_file_save_dialog = _ui.toggle;
}

function UiCheckboxOpenFileAFterSaveInit(_ui)
{
	toggle = config.open_explorer_after_save;
}

function UiCheckboxOpenFileAFterSaveClicked(_ui)
{
	UiCheckboxClicked(_ui);
	
	config.open_explorer_after_save = _ui.toggle;
}

function UiCheckboxUseAmericanDatesInit(_ui)
{
	toggle = config.use_american_dates;
}

function UiCheckboxUseAmericanDatesClicked(_ui)
{
	UiCheckboxClicked(_ui);
	
	config.use_american_dates = _ui.toggle;
}