globalvar config;
config =
{
	visual:
	{
		fancy_drag_box: true,
		favourite_colour: { r: 43, g: 244, b: 170 },
	}
};

var r = config.visual.favourite_colour.r, g = config.visual.favourite_colour.g, b = config.visual.favourite_colour.b;
globalvar favColour;
favColour =
{
	full: make_colour_rgb(r, g, b),
	
	dark: merge_colour(make_colour_rgb(r, g, b), c_black, 0.2),
	darker: merge_colour(make_colour_rgb(r, g, b), c_black, 0.4),
	darkest: merge_colour(make_colour_rgb(r, g, b), c_black, 0.8),
};
