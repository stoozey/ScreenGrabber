if (!surface_exists(surf)) {
	surf = surface_create(width, height);
	buffer_set_surface(buf, surf, 0, 0, 0);
}
var dt = delta_time / 1000000;
fade = min(fade + dt, 1);
var c = merge_color(c_white, $70645F, fade);
draw_surface_ext(surf, 0,0, 1,1, 0, c,1);
