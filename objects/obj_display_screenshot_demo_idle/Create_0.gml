// Attention! You'll need to set up your game
// to run borderless for it to cover the entire screen(s)

// get a screenshot:
display_capture_mode(true); // (we want to cover all screens)
buf = buffer_create(1, buffer_grow, 1);
surf = display_capture_combined(buf);
if (surf < 0) {
	show_message("Couldn't capture!");
	game_end();
	exit;
}

// get sizes:
var r = display_capture_rect;
xoffset = r[0];
yoffset = r[1];
width = r[2];
height = r[3];

// set things up for correct drawing:
window_set_rectangle(xoffset, yoffset, width, height);
display_set_gui_size(width, height);
application_surface_enable(false); // (we're not using it)

//
xcenter = -xoffset + display_get_width() div 2;
ycenter = -yoffset + display_get_height() div 2;
fade = 0;
angle = 0;