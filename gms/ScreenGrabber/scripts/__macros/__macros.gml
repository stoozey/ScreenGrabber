#macro X	0
#macro Y	1

#macro mouse_xx device_mouse_x_to_gui(0)
#macro mouse_yy device_mouse_y_to_gui(0)

#macro DIR_TEMP_SREENSHOT (temp_directory + "\\STOOZEY_SCREENGRABBER_SCREENSHOT.png")
#macro DIR_PROGRAM_DIRECOTRY (environment_get_variable("appdata") + "\\stoozey_\\ScreenGrabber\\")

#macro FILE_CONFIG (DIR_PROGRAM_DIRECOTRY + "screengrabber_config.cfg")

#macro ROOM_SETTINGS_WIDTH	456
#macro ROOM_SETTINGS_HEIGHT	600

#macro print show_debug_message