var _mousePos = [ device_mouse_x_to_gui(0), device_mouse_y_to_gui(0) ];

if ((mouse_check_button_pressed(mb_left)) && (!dragging))
{
	if (!dragging)
	{
		dragging = true;
		DoDraggingTween(1);
	}
	
	rectangle.x1 = _mousePos[X];
	rectangle.y1 = _mousePos[Y];
}

if (!mouse_check_button(mb_left))
{
	if (dragging)
	{
		dragging = false;
		DoDraggingTween(0);
		
		con_screenshot.SaveScreenshot();
	}
	
	exit;
}

switch (dragReversed[X])
{
	case false:
	{
		if (_mousePos[X] < rectangle.x1)
		{
			dragReversed[X] = true;
			rectangle.Reverse("x1", "x2");
		}
		
		rectangle.x2 = _mousePos[X];
	} break;
	
	case true:
	{
		if (_mousePos[X] > rectangle.x2)
		{
			dragReversed[X] = false;
			rectangle.Reverse("x1", "x2");
		}
		
		rectangle.x1 = _mousePos[X];
	} break;
}

switch (dragReversed[Y])
{
	case false:
	{
		if (_mousePos[Y] < rectangle.y1)
		{
			dragReversed[Y] = true;
			rectangle.Reverse("y1", "y2");
		}
		
		rectangle.y2 = _mousePos[Y];
	} break;
	
	case true:
	{
		if (_mousePos[Y] > rectangle.y2)
		{
			dragReversed[Y] = false;
			rectangle.Reverse("y1", "y2");
		}
		
		rectangle.y1 = _mousePos[Y];
	} break;
}