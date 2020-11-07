square = -1;
cap_buf = buffer_create(1, buffer_grow, 1);
cap_surf = -1;
cap_avail = false;
cap_width = 0;
cap_height = 0;
var screens = display_capture_measure_all();
for (var i = 0; i < array_length_1d(screens); i++) {
	var screen = screens[i];
	var msg = screen[9];
	if (screen[8] & 1) msg += " (primary)";
	msg += " " + string(screen[2]) + "x" + string(screen[3])
		+ " at " + string(screen[0]) + "," + string(screen[1]);
	show_debug_message(msg);
}