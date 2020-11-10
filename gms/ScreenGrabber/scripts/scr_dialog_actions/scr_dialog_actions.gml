enum DialogAction
{
	CopyToClipboard,
	SaveToFile,
	UploadToWeb,
	Cancel,
	
	Null,
}

#macro POST_CALL_PREFIX ("\"post_call.exe\" \"" + DIR_TEMP_SREENSHOT + "\" ")

globalvar dialogActions;
dialogActions = array_create(DialogAction.Null, function() {});

dialogActions[DialogAction.CopyToClipboard] =
{
	RunFunction: function() { execute_shell(POST_CALL_PREFIX + "copy_to_clipboard", false); game_end(); },
	
	Name: "Copy to Clipboard"
}

dialogActions[DialogAction.SaveToFile] =
{
	RunFunction: function() { execute_shell(POST_CALL_PREFIX + "save_to_file", false); game_end(); },
	
	Name: "Save to file",
}

dialogActions[DialogAction.UploadToWeb] =
{
	RunFunction: function() { execute_shell(POST_CALL_PREFIX + "upload_to_web", false); game_end(); },
	
	Name: "Upload online",
}

dialogActions[DialogAction.Cancel] =
{
	RunFunction: function() { game_end() },
	
	Name: "Cancel",
}