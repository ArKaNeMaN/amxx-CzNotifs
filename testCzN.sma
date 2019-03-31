#include <amxmodx>
#include <czNotifs>

public plugin_init(){
	register_plugin("Test CZ Notifs", "1.0", "ArKaNeMaN");
	
	register_clcmd("say /czntest1", "showNotif");
	register_clcmd("say /czntest2", "showNotifSub");
}

public showNotif(id){
	czNotifs_showNotif(id, "Test line 1^nTest line 2^nTest line 3", 5.0);
}

public showNotifSub(id){
	czNotifs_showNotif(id, "Test line 1^nTest line 2^nTest line 3", 5.0, "green");
}