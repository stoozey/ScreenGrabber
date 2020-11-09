enum DialogAction
{
	CopyToClipboard,
	SaveToFile,
	Exit,
	
	Null,
}

globalvar dialogActions;
dialogActions = array_create(DialogAction.Null, function() {});

dialogActions[DialogAction.CopyToClipboard] =
{
	RunFunction: function() { execute_shell("\"post_call.exe\" copy_to_clipboard \"" + SCREENSHOT_DIR + "\"", false) },
	
	Name: "Copy to Clipboard"
}

dialogActions[DialogAction.SaveToFile] =
{
	RunFunction: function() { execute_shell("\"post_call.exe\" save_to_file \"" + SCREENSHOT_DIR + "\"", false) },
	
	Name: "Save to file",
}

dialogActions[DialogAction.Exit] =
{
	RunFunction: function() { game_end() },
	
	Name: "Exit",
}