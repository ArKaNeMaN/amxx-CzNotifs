#define _csnotifs_included

#define MAX_TUTOR_CHARS 192

native czNotifs_showLiteNotif(id, const text[], Float:dur = 5.0);
native czNotifs_showNotif(id, const text[], Float:dur = 5.0, const color[] = "y", Array:subNotifs);
native czNotifs_closeNotif(id);