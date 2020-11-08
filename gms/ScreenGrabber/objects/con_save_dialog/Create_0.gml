#macro SAVE_DIALOG_DISTANCE 32

selectedAction = DialogAction.CopyToClipboard;

x = -9000;
y = -9000;

width	= 230;
height	= 380;

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
	DoIntroTween(1);

	var _x = con_cursor.rectangle.x2;
	var _y = con_cursor.rectangle.y1;
	
	x = clamp(_x, width, con_screenshot.screenWidth - width - SAVE_DIALOG_DISTANCE);
	y = clamp(_y - (height * 0.25), (height * 0.25), con_screenshot.screenHeight - height);
}

Deactivate = function()
{
	DoIntroTween(0);
}


Draw = function()
{
	var _x = x + (SAVE_DIALOG_DISTANCE * introAmount);
	var _y = y + SAVE_DIALOG_DISTANCE - (SAVE_DIALOG_DISTANCE * introAmount);
	//_x = ((introDir == -1) ? _x - width : _x);
	draw_9slice(_x, _y, width, max(height * introAmount, 1), spr_9slice_boxier_large, 0, c_white, 1, introAmount);
}