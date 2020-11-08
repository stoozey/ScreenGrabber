buf = buffer_create(1, buffer_grow, 1);
screen = display_capture_combined(buf);
if (screen < 0) {
	show_message("Couldn't capture screen");
	game_end();
	exit;
}

//
width = display_capture_rect[2];
height = display_capture_rect[3];

//
if (false) { // borderless?
	window_set_rectangle(0,0, width,height);
} else window_set_fullscreen(true);

//
larger = max(width, height);
diag = point_distance(0, 0, width, height);

grid = surface_create(width, height);
canvas = surface_create(width, height);
mouse_xp = mouse_x;
mouse_yp = mouse_y;

anim1 = -diag;
anim2 = 0;