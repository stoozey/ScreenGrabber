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