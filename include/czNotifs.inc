#define _cznotifs_included

#define MAX_TUTOR_CHARS 192

native czNotifs_showNotif(id, const text[], Float:dur = 5.0, const color[] = "y"); // Показ сообщения
native czNotifs_closeNotif(id); // Скрывние сообщения