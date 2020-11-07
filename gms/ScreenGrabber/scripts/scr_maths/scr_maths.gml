function is_in_rect(_x, _y, _rect)
{
	return ((_x >= _rect[0]) && (_x <= _rect[2]))
	&& ((_y >= _rect[1]) && (_y <= _rect[3]))
}