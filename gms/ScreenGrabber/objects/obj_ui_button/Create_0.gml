// Inherit the parent event
event_inherited();

nineSliceSpriteOutline = asset_get_index(sprite_get_name(nineSliceSprite) + "_outline");
if (!sprite_exists(nineSliceSpriteOutline)) nineSliceSpriteOutline = spr_null;

GetUiColour = function()
{
	return ((state == UiState.Hover) ? favColour.background_dark : favColour.background_darker);
}