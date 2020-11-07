var _surface = con_cursor.draggingSurface;
if (!surface_exists(_surface)) exit;

draw_surface(_surface, 0, 0);

con_save_dialog.Draw();