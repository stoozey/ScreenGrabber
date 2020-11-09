if (!config.debug) exit;

var _totalLogs = ds_list_size(logs);
if (_totalLogs == 0) exit;

draw_set_halign(fa_right);
draw_set_font(fnt_debug);
draw_set_alpha(0.8);

var _count = 0;
for (var i = _totalLogs - 1; i > (_totalLogs - DEBUG_LOG_MAX); i--)
{
	show_debug_message( string(i) );
	if (i < 0) break;
	
	var _thisLog = logs[| i];
	
	
	draw_text(mouse_xx - 32, mouse_yy - (string_height(_thisLog) * _count++), _thisLog);
}

draw_set_alpha(1);
draw_set_halign(fa_left);