selectedAction = DialogAction.CopyToClipboard;

width	= 230;
height	= 380;

introTween = TweenNull();
introAmount = 0;

DoIntroTween = function(_value)
{
	if (TweenExists(introTween))
		TweenDestroy(introTween);
	
	introTween = TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, true, 0, ((_value == 0) ? 0.3 : 0.45), "introAmount", !_value, _value);
}

Activate = function()
{
	DoIntroTween(1);

	x = mouse_xx;
	y = mouse_yy - (height * 0.25);
}

Deactivate = function()
{
	DoIntroTween(0);
}

#macro SAVE_DIALOG_DISTANCE 32
Draw = function()
{
	var _x = x + (SAVE_DIALOG_DISTANCE * introAmount);
	draw_9slice(_x, y, width, max(height * introAmount, 1), spr_9slice_boxier_large, 0, c_white, 1, introAmount);
}