#include <amxmodx>
#include <czNotifs>

public plugin_init(){
	register_plugin("[CzN] Informer", "1.0", "ArKaNeMaN");
}

public client_putinserver(id){
	set_task(1.0, "task_showInformer", id, _, _, "b");
}

public client_disconnected(id){
	remove_task(id);
}

public task_showInformer(id){
	static text[MAX_TUTOR_CHARS]; formatex(text, MAX_TUTOR_CHARS-1, "TestInformer^n   ID: %d^n   Time: %d", id, get_systime());
	czNotifs_showNotif(id, text, 1.0);
}