if (!surface_exists(screenSurface))
	screenSurface = display_capture_surface_part(window_get_x(), window_get_y(), width, height);

draw_surface(screenSurface, 0, 0);

draw_9slice(0, 0, width, height, spr_9slice_box_large, 0, favColour.background_darker, 1, backgroundAlpha);
draw_9slice(0, 0, width, height, spr_9slice_box_large_outline, 0, favColour.full, 1, backgroundAlpha);