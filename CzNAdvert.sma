/*
	Messages list config:
		
		File:		addons/amxmodx/configs/plugins/CzNAdvert/Messages.cfg
		
		Structure:	CzNAdvert_AddMsg "color" "Text messages"
		
		Example:	CzNAdvert_AddMsg "red" "test msg 1 [red]"
		
		Colors:		- Red: red \ r
					- Blue: blue \ b
					- Yellow: yellow \ y
					- Green: green \ g
*/

#include <amxmodx>
#include <czNotifs>

enum e_msgInfo{
	mi_text[MAX_TUTOR_CHARS],
	mi_color[32],
}

new Array:msgs;
new lastMsg;
new Float:msgsRate = 30.0;
new Float:msgsLifeTime = 5.0;

new const PLUG_NAME[] = "[CzN] Advert";
new const PLUG_VER[] = "1.0";

public plugin_init(){
	register_plugin(PLUG_NAME, PLUG_VER, "ArKaNeMaN");
	
	register_srvcmd("CzNAdvert_AddMsg", "cmd_addMsg");
	msgs = ArrayCreate(e_msgInfo);
	AutoExecConfig(true, "Messages", "CzNAdvert");
	
	cfgExec();
	
	set_task(msgsRate, "showMsg");
	
	server_print("[%s v%s] loaded.", PLUG_NAME, PLUG_VER);
}

public showMsg(){
	static msg[e_msgInfo]; ArrayGetArray(msgs, getNextMsgId(), msg, e_msgInfo);
	czNotifs_showNotif(0, msg[mi_text], msgsLifeTime, msg[mi_color]);
	set_task(msgsRate, "showMsg");
}

public cmd_addMsg(){
	if(read_argc() < 2){
		log_amx("ERROR! Message %d: Number of arguments does not match", ArraySize(msgs)+1);
		return;
	}
	static msg[e_msgInfo];
	read_argv(1, msg[mi_color], charsmax(msg[mi_color]));
	read_argv(2, msg[mi_text], MAX_TUTOR_CHARS-1);
	ArrayPushArray(msgs, msg);
}

cfgExec(){
	bind_pcvar_float(create_cvar("CzNAdvert_MsgsRate", "30.0", FCVAR_NONE, "The period of display of messages"), msgsRate);
	bind_pcvar_float(create_cvar("CzNAdvert_MsgsLifeTime", "5.0", FCVAR_NONE, "Messages lifetime"), msgsLifeTime);
	AutoExecConfig(true, "Main", "CzNAdvert");
}

getNextMsgId(){
	lastMsg = (lastMsg >= ArraySize(msgs)-1) ? 0 : lastMsg+1;
	return lastMsg;
}