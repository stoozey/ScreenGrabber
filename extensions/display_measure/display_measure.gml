#define display_measure_init
//#global display_measure_is_available
global.display_measure_buf = buffer_create(36+128, buffer_fixed, 1);
display_measure_is_available = display_measure_init_raw();

#define display_measure_all
/// @description  ()->array<[screen_x,y,w,h, workspace_x,y,w,h, flags, name]>
var l_num = display_measure_all_start_raw();
var l_res = array_create(0);
var l_buf = global.display_measure_buf;
var l_adr = buffer_get_address(l_buf);
var l_found = 0;
for (var l_i = 0; l_i < l_num; l_i++) {
	if (!display_measure_all_next_raw(l_i, l_adr)) continue;
	var l_arr = array_create(10);
	for (var l_k = 0; l_k < 9; l_k++) {
		l_arr[l_k] = buffer_peek(l_buf, 4*l_k, buffer_s32);
	}
	buffer_seek(l_buf, 0, 40);
	l_arr[9] = buffer_read(l_buf, buffer_string);
	l_res[l_found++] = l_arr;
}
return l_res;

