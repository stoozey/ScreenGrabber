toggle = false;

event_inherited();

draw_set_font(font);
image_xscale = (string_width(text)) + (sprite_get_width(checkboxSprite) * 2);

boxSize		= round(image_yscale * 0.85);
boxPos		= (image_yscale - boxSize) * 0.5;

boxScale		= 0.9;
boxScaleTween	= TweenNull();

GetUiColour = function()
{
	return ((state == UiState.Hover) ? favColour.background_dark : favColour.background_darker);
}