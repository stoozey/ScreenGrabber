#macro SAVE_DIALOG_DISTANCE 32

selectedAction = DialogAction.CopyToClipboard;

x = -9000;
y = -9000;

width	= 1;
draw_set_font(fnt_save_dialog);
for (var i = 0; i < DialogAction.Null; ++i)
	width = max(width, string_width(dialogActions[i].Name) + 28);
dialogItemHeight = string_height("W") + 16;

height	= (DialogAction.Null * dialogItemHeight);

active = false;

selectionPos			= -900;
selectionValue			= 0;
selectionPosTo			= selectionPos;
selectionNextPos		= selectionPos;
selectionTween			= TweenNull();
selectionSlideInTween	= TweenNull();

introTween = TweenNull();
introAmount = 0;
introDir	= 1;

DoIntroTween = function(_value)
{
	if (TweenExists(introTween))
		TweenDestroy(introTween);
	
	introTween = TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, true, 0, ((_value == 0) ? 0.3 : 0.45), "introAmount", !_value, _value);
}

Activate = function()
{
	active = true;
	DoIntroTween(1);

	var _x = con_cursor.rectangle.x2;
	var _y = con_cursor.rectangle.y1;
	
	var _xMax = width - SAVE_DIALOG_DISTANCE;
	if (_x >= con_screenshot.screenWidth - _xMax)
		_x = con_cursor.rectangle.x1 - _xMax - (SAVE_DIALOG_DISTANCE * 2);
	
	x = max(_x, width);
	y = clamp(_y - (height * 0.25), (height * 0.25), con_screenshot.screenHeight - height);
}

Deactivate = function()
{
	if (introAmount != 1) return;
	
	TweenFire(id, EaseInOutSine, TWEEN_MODE_ONCE, true, 0, 0.2, "selectionValue", selectionValue, 0);
	
	active = false;	
	DoIntroTween(0);
}

Draw = function()
{
	draw_set_font(fnt_save_dialog);
	draw_set_alpha(introAmount);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	var _heightBuffer = 32;
	var _introX = (SAVE_DIALOG_DISTANCE * introAmount);
	var _x = x + _introX;
	var _y = y + (SAVE_DIALOG_DISTANCE - (SAVE_DIALOG_DISTANCE * introAmount));

	// backdrop, selection, outline
	draw_9slice(_x, _y, width, (height * introAmount) + _heightBuffer, spr_9slice_boxier_large, 0, favColour.background_darker, 1);
	
	if (introAmount > 0.7)
		draw_9slice(_x, selectionPos, max(width * selectionValue, 1), dialogItemHeight, spr_9slice_box_large, 0, favColour.background_dark, 1, 1);
		
	draw_9slice(_x, _y, width, (height * introAmount) + _heightBuffer, spr_9slice_boxier_large_outline, 0, favColour.full, 1);
	
	var _lineHeight = 3, _lineWidthBuffer = 14;
	_y += (_heightBuffer * 0.5);
	
	var _selected = false;
	draw_set_colour(favColour.full);
	for (var i = 0; i < DialogAction.Null; i++)
	{
		var _thisAction = dialogActions[i];
		var _rect = [ _x, _y, _x + width, _y + dialogItemHeight ];
		
		if ((i > 0) && (i < DialogAction.Null))
			draw_9slice(_x + _lineWidthBuffer, _y - _lineHeight, width - (_lineWidthBuffer * 2), _lineHeight, spr_9slice_boxier_small, 0, favColour.dark, 1, introAmount);
			
		draw_text(_x + (width * 0.5), _y + (dialogItemHeight * 0.5), _thisAction.Name);
		
		_y += dialogItemHeight;

		if (!is_in_rect(mouse_xx, mouse_yy, _rect)) continue;
		_selected = true;
		
		selectionPosTo = _rect[1];
		if (selectionValue == 0)
		{
			selectionPos = selectionPosTo;
			selectionSlideInTween = TweenFire(id, EaseInOutSine, TWEEN_MODE_ONCE, true, 0, 0.2, "selectionValue", selectionValue, 1);
		}
		
		if (!mouse_check_button_pressed(mb_left)) continue;
		selectedAction = i;
		con_screenshot.SaveScreenshot();
	}
	
	selectionPos = Ease(selectionPos, selectionPosTo, 0.45, EaseInOutQuart);
	
	if ((!_selected) && (selectionValue == 1))
		selectionSlideInTween = TweenFire(id, EaseInOutCubic, TWEEN_MODE_ONCE, true, 0, 0.15, "selectionValue", selectionValue, 0);
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_alpha(1);
}