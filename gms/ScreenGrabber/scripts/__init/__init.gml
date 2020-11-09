globalvar config;
config =
{
	visual:
	{
		fancy_drag_box: true,
		favourite_colour: { h: 110, s: 190, l: 187 },
	},
	
	debug: true,
};

var h = config.visual.favourite_colour.h, s = config.visual.favourite_colour.s, l = config.visual.favourite_colour.l;
var _baseColour = make_colour_hsv(h, s, l);//HslToHsv(h, s, l);
globalvar favColour;
favColour =
{
	full: _baseColour,
	
	dark:		merge_colour(_baseColour,	c_black, 0.2),
	darker:		merge_colour(_baseColour,	c_black, 0.4),
	darkest:	merge_colour(_baseColour,	c_black, 0.8),
	
	background:			make_colour_rgb(45, 47, 62),
	background_dark:	make_colour_rgb(40, 42, 54),
	background_darker:	make_colour_rgb(33, 34, 44),
};
