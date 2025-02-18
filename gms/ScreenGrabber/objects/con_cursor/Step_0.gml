var _mousePos = [ mouse_xx, mouse_yy ];

var _rect = [ con_save_dialog.x, con_save_dialog.y, con_save_dialog.x + con_save_dialog.width, con_save_dialog.y + con_save_dialog.height ];
if ((con_save_dialog.active) && (is_in_rect(_mousePos[X], _mousePos[Y], _rect))) exit;

if ((mouse_check_button_pressed(mb_left)) && (!dragging))
{
	if (!dragging)
	{
		rectangle.Reset();
		
		dragging = true;
		DoDraggingTween(1);
		
		con_save_dialog.Deactivate();
	}
	
	rectangle.x1 = _mousePos[X];
	rectangle.y1 = _mousePos[Y];
}

if (!mouse_check_button(mb_left))
{
	if (dragging)
	{
		dragging = false;
		
		if (rectangle.GetWidth() != 0) && (rectangle.GetHeight() != 0)
			con_save_dialog.Activate();
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