scale	= 1;
alpha	= 1;

TweenFire(id, EaseInOutCubic, TWEEN_MODE_ONCE, true, 0, 0.35, "alpha", 0, 1);

enum UiState
{
	Inactive,
	Hover,
	Clicked,
	Disabled,
	
	Null,
}

tweens = { };

state = UiState.Inactive;

stateFunctions = array_create(UiState.Null);

GetRect = function()
{
	return [ x, y, x + image_xscale, y + image_yscale ];
}

stateFunctions[UiState.Inactive] = function()
{
	if (is_in_rect(mouse_xx, mouse_yy,GetRect()))
	{
		state = UiState.Hover;
		funcHoverOn(id);
	}
}

stateFunctions[UiState.Hover] = function()
{
	if (!is_in_rect(mouse_xx, mouse_yy,GetRect()))
	{
		state = UiState.Inactive;
		funcHoverOff(id);
		
		return;
	}
	
	if (!mouse_check_button_pressed(mb_left)) return;
	
	state = UiState.Clicked;
	funcClicked(id);
}

stateFunctions[UiState.Clicked] = function()
{
	switch (useClickToggling)
	{
		case true:
			if (!mouse_check_button_pressed(mb_left)) return;
			
			state = UiState.Hover;
			funcClicked(id);
			break;
		
		case false: state = UiState.Hover; break;
	}
}

stateFunctions[UiState.Disabled] = function()
{
	
}