if (introAmount < 1) exit;

if (keyboard_check_pressed(ord("1")))
{
	con_screenshot.SaveScreenshot();
	game_end();
}