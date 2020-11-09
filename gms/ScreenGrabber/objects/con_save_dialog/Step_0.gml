///@desc shortcuts

if (introAmount < 1) exit;
if (!keyboard_check_pressed(vk_anykey)) exit;

for (var i = 0; i < DialogAction.Null; ++i)
{
    if (ord(string(i)) != keyboard_key) continue;
	
	selectedAction = i;
	con_screenshot.SaveScreenshot();
}