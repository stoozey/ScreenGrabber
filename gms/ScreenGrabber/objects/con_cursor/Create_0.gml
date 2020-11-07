rectangle =
{
	x1:	0,
	y1:	0,
	
	x2:	0,
	y2:	0,
	
	GetWidth:	function() { return (self.x2 - self.x1) },
	GetHeight:	function() { return (self.y2 - self.y1) },
	
	Get: function()
	{
		x1	= min(self.x1, self.x2);
		x2	= max(self.x1, self.x2);
		y1	= min(self.y1, self.y2);
		y2	= max(self.y1, self.y2);
		
		return self;
	},
	
	Reverse: function(_aName, _bName)
	{
		var _a = variable_struct_get(self, _aName);
		var _b = variable_struct_get(self, _bName);
		
        _a	= (_a & _b) + (_a | _b);
        _b	= _a + (~_b) + 1;
        _a	= _a + (~_b) + 1;

		variable_struct_set(self, _aName, _a);
		variable_struct_set(self, _bName, _b);
	},
};

#macro CON_CURSOR_DRAGGING_BACKGROUND_ALPHA	0.5
#macro CON_CURSOR_DRAGGING_BOX_ALPHA		0.25

dragging		= false;
dragReversed	= [ false, false ];

draggingSurface	= -1;

draggingAlpha = 0;
draggingTween = TweenNull();

DoDraggingTween = function(_alpha)
{
	if (TweenExists(draggingTween))
		TweenDestroy(draggingTween);
	
	draggingTween = TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, true, 0, 0.2, "draggingAlpha", -_alpha, _alpha);
}