display_capture_mode(true); // capture all screens

screenBuffer	= buffer_create(1, buffer_grow, 1);
screenSurface	= display_capture_combined(screenBuffer);

if (screenSurface < 0)
{
	show_error("Couldn't Capture!", true);
}

var _rect = display_capture_rect;
screenXOffset	= _rect[0];
screenYOffset	= _rect[1];
screenWidth		= _rect[2];
screenHeight	= _rect[3];

window_set_rectangle(screenXOffset, screenYOffset, screenWidth, screenHeight);
display_set_gui_size(screenWidth, screenHeight);
application_surface_enable(false);

screenFade	= 0;
TweenFire(id, EaseOutCubic, TWEEN_MODE_ONCE, true, 0, 0.45, "screenFade", 1, 0);

Draw = function()
{
	if (!surface_exists(screenSurface))
	{
		screenSurface = surface_create(screenWidth, screenHeight);
		buffer_set_surface(screenBuffer, screenSurface, 0, 0, 0);
	}

	var _colour = merge_color(c_white, $560005, screenFade);
	draw_surface_ext(screenSurface, 0, 0, 1, 1, 0, _colour, 1);
}

SaveScreenshot = function()
{
	var _rect, _width, _height;
	with (con_cursor)
	{
		_rect	= rectangle.Get();
		_width	= rectangle.GetWidth();
		_height	= rectangle.GetHeight();
	}
	
	if ((_width <= 0) || (_height <= 0))
	{
		show_message("Screenshot dimensions cannot be 0 pixels or less.")
		return;
	}

	var _shotSurface = surface_create(_width, _height);

	surface_set_target(_shotSurface);
		draw_surface(screenSurface, -_rect.x1, -_rect.y1);
	surface_reset_target();

	surface_save(_shotSurface, SCREENSHOT_DIR);
	surface_free(_shotSurface);
	
	with (con_save_dialog)
	{
		dialogActions[selectedAction].RunFunction();
	}
}