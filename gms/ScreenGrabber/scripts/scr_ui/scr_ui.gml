function UiGetScale(_ui)
{
	var _scale = _ui.scale;
	return [ _ui.image_xscale * _scale, _ui.image_yscale * _scale ];
}

function UiGetPos(_ui)
{
	var _scale = UiGetScale(_ui);
	return [ x - ((_scale[X] - image_xscale) / 2), y - ((_scale[Y] - image_yscale) / 2) ];
}

function UiDoScaleTween(_ui, _scale, _mode, _time)
{
	if (!variable_struct_exists(_ui.tweens, "mouseEvents"))
		variable_struct_set(_ui.tweens, "mouseEvents", TweenNull());
	
	if (TweenExists(_ui.tweens.mouseEvents))
		TweenFinish(_ui.tweens.mouseEvents);
	
		
	tweens.mouseEvents = TweenFire(_ui, EaseOutBack, _mode, true, 0, _time, "scale", scale, _scale);
}

function UiTweenClicked(_ui)
{
	UiDoScaleTween(_ui, 1.1, TWEEN_MODE_BOUNCE, 0.08);
}

function UiTweenHoverOn(_ui)
{
	UiDoScaleTween(_ui, 1.05, TWEEN_MODE_ONCE, 0.2);
}

function UiTweenHoverOff(_ui)
{
	UiDoScaleTween(_ui, 1, TWEEN_MODE_ONCE, 0.15);
}

function UiCheckboxClicked(_ui)
{
	_ui.toggle = !_ui.toggle;
	
	UiTweenClicked(_ui);
	
	if (TweenExists(boxScaleTween))
		TweenFinish(boxScaleTween);
	
	boxScaleTween = TweenFire(_ui, EaseOutBack, TWEEN_MODE_BOUNCE, true, 0, 0.15, "boxScale", 0.9, 1);
}