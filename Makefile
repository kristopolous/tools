CFLAGS="-g3"
waitfor: waitfor.o inotify.o
	make inotify
inotify: inotify.o
