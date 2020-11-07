var _rect = rectangle.Get();

var _shotSurface = surface_create(_rect.GetWidth(), _rect.GetHeight());

surface_set_target(_shotSurface);
	draw_surface(con_screenshot.screenSurface, -_rect.x1, -_rect.y1);
surface_reset_target();

var _filename = "D:\\Dev\\__ScreenGrabber\\Screenshots\\" + "ss.png";

surface_save(_shotSurface, _filename);
surface_free(_shotSurface);