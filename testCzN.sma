#include <amxmodx>
#include <czNotifs>

public plugin_init(){
	register_plugin("Test CZ Notifs", "1.0", "ArKaNeMaN");
	
	register_clcmd("say /czntest", "showNotif");
}

public showNotif(id){
	czNotifs_showLiteNotif(id, "Test line 1^nTest line 2^n Test line 3", 5.0);
}