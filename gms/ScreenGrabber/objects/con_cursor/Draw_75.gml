if (draggingAlpha == 0)
{
	con_screenshot.Draw();
	
	exit;
}

var _rect	= rectangle.Get();
var _width	= _rect.GetWidth();
var _height	= _rect.GetHeight();

var _screenWidth	= con_screenshot.screenWidth;
var _screenHeight	= con_screenshot.screenHeight;

if (!surface_exists(draggingSurface))
	draggingSurface = surface_create(_screenWidth, _screenHeight);

surface_set_target(draggingSurface);
	con_screenshot.Draw();

	draw_set_alpha(CON_CURSOR_DRAGGING_BACKGROUND_ALPHA * draggingAlpha);
		draw_rectangle_colour(0, 0, _screenWidth, _screenHeight, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);

	gpu_set_blendmode(bm_subtract);
		
		switch ((_width <= 0) || (_height <= 0))
		{
			case true:
				draw_rectangle(_rect.x1, _rect.y1, _rect.x2, _rect.y2, false);
				break;
			
			case false:
			{
				switch (config.visual.fancy_drag_box)
				{
					case true:
						draw_9slice(_rect.x1, _rect.y1, _width, _height, spr_9slice_boxier_small, 0, c_black);
						break;
	
					case false:
						draw_rectangle(_rect.x1, _rect.y1, _rect.x2, _rect.y2, false);
						break;
				}
			} break;
		}
		
	gpu_set_blendmode(bm_normal);
surface_reset_target();

con_screenshot.Draw();
draw_surface(draggingSurface, 0, 0);