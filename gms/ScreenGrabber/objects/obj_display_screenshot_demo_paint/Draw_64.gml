var dt = delta_time / 1000000;
var redraw_grid = false;
if (anim1 < diag + larger) {
	anim1 += dt * diag / 0.3;
} else if (anim2 < larger * 2) {
	redraw_grid = true;
	anim2 += dt * larger / 0.4;
}

// screenshot in the background:
if (!surface_exists(screen)) {
	screen = surface_create(width, height);
	buffer_set_surface(buf, screen, 0, 0, 0);
}
draw_surface(screen, 0, 0);
draw_set_alpha(0.7);
draw_set_color(c_black);
if (anim1 < diag + larger) {
	draw_triangle(-1,-1, anim1+1,-1, -1,anim1+1, false);
} else draw_rectangle(-1, -1, width + 1, height + 1, false);

// grid:
if (!surface_exists(grid)) {
	grid = surface_create(width, height);
	redraw_grid = true;
}
if (redraw_grid) {
	surface_set_target(grid);
	draw_clear_alpha(c_white, 0);
	gpu_set_colorwriteenable(0,0,0,1);
	draw_set_alpha(0.6);
	draw_set_color(c_white);
	draw_text(0, 0, string(anim2));
	for (var i = 0; i < larger; i += 20) if (anim2 > i) {
		draw_set_alpha(i % 100 ? 0.2 : 0.6);
		if (i < width) draw_line(i,height+1, i,height-anim2+i);
		if (i < height) draw_line(width+1,i, width-anim2+i,i);
	}
	surface_reset_target();
	gpu_set_colorwriteenable(1,1,1,1);
}
draw_set_alpha(1);
draw_surface(grid, 0, 0);

// canvas & drawing:
var canvas_clear = keyboard_check_pressed(vk_backspace);
if (!surface_exists(canvas)) {
	canvas = surface_create(width, height);
	canvas_clear = true;
}
if (canvas_clear) {
	surface_set_target(canvas);
	draw_clear_alpha(c_white, 0);
	surface_reset_target();
}
var paint = 0;
if (mouse_check_button(mb_left)) paint = 1;
if (mouse_check_button(mb_right)) paint = -1;
if (paint != 0) {
	// drawing half-decent lines is a complicated matter
	surface_set_target(canvas);
	draw_set_color(c_white);
	gpu_set_blendmode(paint > 0 ? bm_add : bm_subtract);
	var len = point_distance(mouse_xp, mouse_yp, mouse_x, mouse_y);
	var dir = point_direction(mouse_xp, mouse_yp, mouse_x, mouse_y);
	var lx = lengthdir_x(1, dir);
	var ly = lengthdir_y(1, dir);
	var pos = 0;
	while (pos <= len) {
		draw_circle(mouse_xp + lx * pos, mouse_yp + ly * pos, 10, false);
		if (pos < len) {
			pos = min(pos + 2, len);
		} else pos += 1;
	}
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}
draw_surface_ext(canvas, 4,4, 1,1, 0, 0,1);
draw_surface(canvas, 0,0);
mouse_xp = mouse_x;
mouse_yp = mouse_y;

draw_set_alpha(1);