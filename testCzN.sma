#include <amxmodx>
#include <hamsandwich>
#include <czNotifs>

public plugin_init(){
	register_plugin("Test CZ Notifs", "1.0", "ArKaNeMaN");
	
	register_clcmd("say /czntest1", "showNotif");
	register_clcmd("say /czntest2", "showNotifSub");
}

public showNotif(id){
	czNotifs_showLiteNotif(id, "Test line 1^nTest line 2^nTest line 3", 5.0);
}

public showNotifSub(id){
	new Array:subs = ArrayCreate(MAX_TUTOR_CHARS);
	ArrayPushString(subs, "Test sub 1");
	ArrayPushString(subs, "Test sub 3");
	ArrayPushString(subs, "Test sub 4");
	czNotifs_showNotif(id, "Test line 1^nTest line 2^nTest line 3", 5.0, "green", subs);
}