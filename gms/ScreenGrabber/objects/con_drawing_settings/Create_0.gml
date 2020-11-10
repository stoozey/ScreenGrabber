display_capture_mode(false);

screenSurface = -1;

width	= window_get_width();
height	= window_get_height();

backgroundAlpha = 1;
TweenFire(id, EaseInOutCubic, TWEEN_MODE_ONCE, true, 0, 0.35, "backgroundAlpha", 0, 1);