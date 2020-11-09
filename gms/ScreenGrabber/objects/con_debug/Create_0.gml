#macro DEBUG_LOG_MAX 5

logs = ds_list_create();

Log = function(_text)
{
	ds_list_add(logs, string(_text));
}