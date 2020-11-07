enum DialogAction
{
	CopyToClipboard,
	
	Null,
}

globalvar dialogActions;
dialogActions = array_create(DialogAction.Null, function(_filename) {});

dialogActions[DialogAction.CopyToClipboard] = function(_filename)
{
	execute_shell("\"post_call.exe\" copy_to_clipboard \"" + _filename + "\"", false);
}