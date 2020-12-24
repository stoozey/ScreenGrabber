// Saving:
var sf = undefined;
if (keyboard_check_pressed(ord("1"))) {
	display_capture_mode(false);
	sf = display_capture_surface();
}
if (keyboard_check_pressed(ord("2"))) {
	display_capture_mode(true);
	sf = display_capture_surface();
}
if (sf != undefined) {
	if (sf != -1) {
		var s = get_save_filename("PNG images|*.png", "");
		if (s != "") surface_save(sf, s);
		surface_free(sf);
	} else {
		show_message("Failed to screenshot");
	}
}

//
if (keyboard_check_pressed(ord("3"))) {
	var sf = display_capture_combined_part(
		display_mouse_get_x() - 240,
		display_mouse_get_y() - 240,
		480, 480, cap_buf, cap_surf);
	if (sf != -1) {
		cap_avail = true;
		cap_surf = sf;
		cap_width = display_capture_rect[2];
		cap_height = display_capture_rect[3];
	}
}
if (cap_avail) {
	if (!surface_exists(cap_surf)) {
		cap_surf = surface_create(cap_width, cap_height);
		buffer_set_surface(cap_buf, cap_surf, 0);
	}
	gpu_set_tex_filter(true);
	draw_surface_ext(cap_surf, 0,0, 0.5,0.5, 0, -1,1);
}
//
var sf = display_capture_surface_part(
	display_mouse_get_x() - 60,
	display_mouse_get_y() - 60,
	120, 120, square
);
if (sf != -1) {
	square = sf;
	gpu_set_tex_filter(false);
	draw_surface_ext(sf, room_width-240,0, 2,2, 0, -1,1);
}

draw_set_font(fnt_display_screenshot_demo);
var s = "Try things:"
	+ "\n1: Take screenshot of main screen"
	+ "\n2: Take screenshot of all screens"
	+ "\n3: Capture a medium-sized section"
	+ "\nCheck out the downloadable demos!";
draw_set_color(c_black);
draw_text(6, 6, s);
draw_set_color(c_white);
draw_text(5, 5, s);