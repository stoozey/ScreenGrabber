draw_set_alpha(alpha);

var _scale	= UiGetScale(id);
var _pos	= UiGetPos(id);

var _hasNoOutline	= (nineSliceSpriteOutline == spr_null);
var _colourFill		= ((_hasNoOutline) ? colour : GetUiColour());
var _colourOutline	= ((_hasNoOutline) ? GetUiColour() : colour);

switch (use9Slice)
{
	case true:
	{
		draw_9slice(_pos[X], _pos[Y], _scale[X], _scale[Y], nineSliceSprite, 0, _colourFill, 1, alpha);
		draw_9slice(_pos[X], _pos[Y], _scale[X], _scale[Y], nineSliceSpriteOutline, 0, _colourOutline, 1, alpha);
	} break;
	
	case false:
	{
		draw_sprite_stretched_ext(nineSliceSprite, 0, _pos[X], _pos[Y], _scale[X], _scale[Y], _colourFill, alpha)
		draw_sprite_stretched_ext(nineSliceSpriteOutline, 0, _pos[X], _pos[Y], _scale[X], _scale[Y], _colourOutline, alpha);
	} break;
}


if (text == "") exit;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(colour);
draw_set_font(font);

draw_text_transformed(_pos[X] + (_scale[X] * 0.5) + textXBuffer, _pos[Y] + (_scale[Y] * 0.5) + textYBuffer, text, scale, scale, 0);

draw_set_colour(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

draw_set_alpha(1);