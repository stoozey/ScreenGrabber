enum DialogAction
{
	CopyToClipboard,
	
	Null,
}

globalvar dialogActions;
dialogActions = array_create(DialogAction.Null, function() {});

dialogActions[DialogAction.CopyToClipboard] = function()
{
	execute_shell("\"post_call.exe\" copy_to_clipboard \"" + SCREENSHOT_DIR + "\"", false);
}