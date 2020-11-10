draw_set_alpha(alpha);

var _scale	= UiGetScale(id);
var _pos	= UiGetPos(id);

draw_9slice(_pos[X], _pos[Y], _scale[X], _scale[Y], nineSliceSprite, 0, GetUiColour(), 1, alpha);

var _boxPos = [ _pos[X] + boxPos + ((_scale[Y] - image_yscale) * 0.5), _pos[Y] + boxPos + ((_scale[Y] - image_yscale) * 0.5) ]
draw_9slice(_boxPos[X], _boxPos[Y], boxSize, boxSize, spr_9slice_box_small, 0, ((toggle) ? favColour.dark : favColour.background), 1, alpha);

var _iconSize			= sprite_get_width(checkboxSprite);
var _iconSizeAdjusted	= _iconSize * 0.6;
var _iconPos			= [ _boxPos[X] + _iconSizeAdjusted, _boxPos[Y] + _iconSizeAdjusted, ];

draw_sprite_ext(checkboxSprite, toggle, _iconPos[X], _iconPos[Y], 1, 1, 0, ((toggle) ? favColour.background : favColour.dark), alpha);


if (text == "") exit;

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_colour(colour);
draw_set_font(font);

var _textBuffer = 6;
draw_text_transformed(_iconPos[X] + (_iconSize * 0.65) + _textBuffer + textXBuffer, _pos[Y] + (_scale[Y] * 0.5) + textYBuffer, text, scale, scale, 0);

draw_set_colour(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

draw_set_alpha(1);