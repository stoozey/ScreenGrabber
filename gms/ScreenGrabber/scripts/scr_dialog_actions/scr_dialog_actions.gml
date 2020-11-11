enum DialogAction
{
	CopyToClipboard,
	SaveToFile,
	UploadToWeb,
	Cancel,
	
	Null,
}

#macro POST_CALL_PREFIX ("\"post_call.exe\" \"" + DIR_TEMP_SREENSHOT + "\" ")

#macro CMD_COPY_TO_CLIPBOARD	"copy_to_clipboard"
#macro CMD_SAVE_TO_FILE			"save_to_file"
#macro CMD_UPLOAD_TO_WEB		"upload_to_web"

globalvar dialogActions;
dialogActions = array_create(DialogAction.Null, function() {});

function PostCall()
{
	var _string = POST_CALL_PREFIX;
	for (var i = 0; i < argument_count; i++)
	{
		_string += argument[i];
		
		if (i == (argument_count - 1)) break;
		_string += " ";
	}
	
	if ((config.after_screenshot.copy_to_clipboard) && (string_pos(CMD_COPY_TO_CLIPBOARD, _string) == 0))
		_string += " " + CMD_COPY_TO_CLIPBOARD;
	
	execute_shell(_string, false);
}

dialogActions[DialogAction.CopyToClipboard] =
{
	RunFunction: function() { PostCall(CMD_COPY_TO_CLIPBOARD); game_end(); },
	
	Name: "Copy to Clipboard"
}

dialogActions[DialogAction.SaveToFile] =
{
	RunFunction: function() { PostCall(CMD_SAVE_TO_FILE); game_end(); },
	
	Name: "Save to File",
}

dialogActions[DialogAction.UploadToWeb] =
{
	RunFunction: function() { PostCall(CMD_UPLOAD_TO_WEB); game_end(); },
	
	Name: "Upload to Web",
}

dialogActions[DialogAction.Cancel] =
{
	RunFunction: function() { game_end() },
	
	Name: "Cancel",
}