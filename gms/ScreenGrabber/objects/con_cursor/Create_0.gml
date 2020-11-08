rectangle =
{
	x1:	0,
	y1:	0,
	
	x2:	0,
	y2:	0,
	
	GetWidth:	function() { return (self.x2 - self.x1) },
	GetHeight:	function() { return (self.y2 - self.y1) },
	
	Get: function()
	{
		x1	= min(self.x1, self.x2);
		x2	= max(self.x1, self.x2);
		y1	= min(self.y1, self.y2);
		y2	= max(self.y1, self.y2);
		
		return self;
	},
	
	Reverse: function(_aName, _bName)
	{
		var _a = variable_struct_get(self, _aName);
		var _b = variable_struct_get(self, _bName);
		
        _a	= (_a & _b) + (_a | _b);
        _b	= _a + (~_b) + 1;
        _a	= _a + (~_b) + 1;

		variable_struct_set(self, _aName, _a);
		variable_struct_set(self, _bName, _b);
	},
	
	Reset: function()
	{
		self.x1	= 0;
		self.x2	= 0;
		self.y1	= 0;
		self.y2	= 0;
	}
};

#macro CON_CURSOR_DRAGGING_BACKGROUND_ALPHA	0.5
#macro CON_CURSOR_DRAGGING_BOX_ALPHA		0.25

dragging		= false;
dragReversed	= [ false, false ];

draggingSurface	= -1;

draggingAlpha = 0.2;
draggingTween = TweenNull();

DoDraggingTween = function(_alpha)
{
	if (TweenExists(draggingTween))
		TweenDestroy(draggingTween);
	
	draggingTween = TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, true, 0, 0.2, "draggingAlpha", draggingAlpha, _alpha);
}

DoDraggingTween(0.2);

Draw = function()
{
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
}