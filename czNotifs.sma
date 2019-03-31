#include <amxmodx>
#include <czNotifs>

#define isNotifShowed(%1) task_exists(%1)

enum e_notifMsgs{
	msg_show,
	msg_close,
}

enum notifColors{
	nc_red = 1,
	nc_blue,
	nc_yellow,
	nc_green,
}

new notifMsgs[e_notifMsgs];

#define PLUG_NAME "CZ Notifs"
#define PLUG_VER "2.0"

public plugin_init(){
	register_plugin(PLUG_NAME, PLUG_VER, "ArKaNeMaN");
	
	notifMsgs[msg_show] = get_user_msgid("TutorText");
	notifMsgs[msg_close] = get_user_msgid("TutorClose");
	
	server_print("[%s v%s] loaded.", PLUG_NAME, PLUG_VER);
}

public plugin_precache(){
	new const g_TutorPrecache[][] = {
		"gfx/career/icon_!.tga",
		"gfx/career/icon_!-bigger.tga",
		"gfx/career/icon_i.tga",
		"gfx/career/icon_i-bigger.tga",
		"gfx/career/icon_skulls.tga",
		"gfx/career/round_corner_ne.tga",
		"gfx/career/round_corner_nw.tga",
		"gfx/career/round_corner_se.tga",
		"gfx/career/round_corner_sw.tga",
		"resource/TutorScheme.res",
		"resource/UI/TutorTextWindow.res",
	}
	for(new i = 0; i < sizeof(g_TutorPrecache); i++) precache_generic(g_TutorPrecache[i]);
}

public plugin_natives(){
	register_native("czNotifs_showNotif", "_showNotif");
	register_native("czNotifs_closeNotif", "_closeNotif");
}

public _showNotif(plugId, argsNum){
	static id; id = get_param(1);
	static text[MAX_TUTOR_CHARS]; get_string(2, text, MAX_TUTOR_CHARS-1);
	static Float:dur; dur = get_param_f(3);
	static strColor[32], notifColors:color;
	get_string(4, strColor, charsmax(strColor));
	color = getColorType(strColor);
	showNotif(id, text, dur, color);
}

public _closeNotif(){
	static id; id = get_param(1);
	closeNotif(id);
}

showNotif(id, const text[MAX_TUTOR_CHARS], Float:dur = 5.0, notifColors:color = nc_yellow){
	if(!id){
		for(new i = 1; i <= MAX_PLAYERS; i++) if(is_user_connected(i)) showNotif(i, text, dur, color);
		return;
	}
	
	if(!is_user_connected(id)) return;
	
	if(isNotifShowed(id)) closeNotif(id);
	
	message_begin(MSG_ONE_UNRELIABLE, notifMsgs[msg_show], _, id);
	write_string(text);
	write_byte(0);
	write_short(0);
	write_short(0);
	write_short(1<<_:color);
	message_end();
	
	if(dur > 0.0) set_task(dur, "task_closeNotif", id);
	
}

public task_closeNotif(id) closeNotif(id);

closeNotif(id){
	if(!id){
		for(new i = 1; i <= MAX_PLAYERS; i++) if(is_user_connected(i)) closeNotif(i);
		return;
	}
	
	if(isNotifShowed(id)) remove_task(id);
	if(is_user_connected(id)){
		message_begin(MSG_ONE_UNRELIABLE, notifMsgs[msg_close], _, id);
		message_end();
	}
}

notifColors:getColorType(const strColor[] = ""){
	if(equal(strColor, "green") || equal(strColor, "g")) return nc_green;
	else if(equal(strColor, "red") || equal(strColor, "r")) return nc_red;
	else if(equal(strColor, "blue") || equal(strColor, "b")) return nc_blue;
	else if(equal(strColor, "yellow") || equal(strColor, "y")) return nc_yellow;
	return notifColors:random_num(_:nc_red, _:nc_green);
}