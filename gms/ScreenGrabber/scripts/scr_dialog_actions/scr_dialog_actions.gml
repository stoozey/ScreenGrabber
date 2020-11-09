enum DialogAction
{
	CopyToClipboard,
	SaveToFile,
	CopyAndSaveToFile,
	UploadToWeb,
	Cancel,
	
	Null,
}

globalvar dialogActions;
dialogActions = array_create(DialogAction.Null, function() {});

dialogActions[DialogAction.CopyToClipboard] =
{
	RunFunction: function() { execute_shell("\"post_call.exe\" copy_to_clipboard \"" + DIR_TEMP_SREENSHOT + "\"", false); game_end(); },
	
	Name: "Copy to Clipboard"
}

dialogActions[DialogAction.SaveToFile] =
{
	RunFunction: function() { execute_shell("\"post_call.exe\" save_to_file \"" + DIR_TEMP_SREENSHOT + "\"", false); game_end(); },
	
	Name: "Save to file",
}

dialogActions[DialogAction.CopyAndSaveToFile] =
{
	RunFunction: function() { execute_shell("\"post_call.exe\" copy_and_save_to_file \"" + DIR_TEMP_SREENSHOT + "\"", false); game_end(); },
	
	Name: "Copy & save to file",
}

dialogActions[DialogAction.UploadToWeb] =
{
	RunFunction: function() { execute_shell("\"post_call.exe\" upload_to_web \"" + DIR_TEMP_SREENSHOT + "\"", false); game_end(); },
	
	Name: "Upload online",
}

dialogActions[DialogAction.Cancel] =
{
	RunFunction: function() { game_end() },
	
	Name: "Cancel",
}