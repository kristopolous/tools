/*
 * "waits for" the files specified as arguments to be modified
 * and then exits.
 *
 * This is useful in situations say, where you need modify some source
 * file and your application uses say, a minified compressed version
 * of concatenated sources.
 *
 * Here you can do something like
 *
 * #!/bin/bash
 * while [ 0 ]; do
 *  waitfor js/*js && tools/deploy.sh
 * done
 *
 */
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/inotify.h>
#include <sys/select.h>

#define ARGS IN_ONESHOT | IN_ALL_EVENTS
#define EVENT_SIZE  (sizeof (struct inotify_event))
#define BUF_LEN        (1024 * (EVENT_SIZE + 16))
char buf[BUF_LEN];

struct {
  int bit;
  char *desc;
} map[] = {
  { IN_ACCESS, "IN_ACCESS" },
  { IN_ATTRIB, "IN_ATTRIB" },
  { IN_CLOSE_WRITE, "IN_CLOSE_WRITE" },
  { IN_CLOSE_NOWRITE, "IN_CLOSE_NOWRITE" },
  { IN_CREATE, "IN_CREATE" },
  { IN_DELETE, "IN_DELETE" },
  { IN_DELETE_SELF, "IN_DELETE_SELF" },
  { IN_MODIFY, "IN_MODIFY" },
  { IN_MOVE_SELF, "IN_MOVE_SELF" },
  { IN_MOVED_FROM, "IN_MOVED_FROM" },
  { IN_MOVED_TO, "IN_MOVED_TO" },
  { IN_OPEN, "IN_OPEN" }
};

int main(int argc, char*argv[]) {
  int 
    len,
    ix,
    i,
    iy,
    fd = 0,
    mapLen = 12,
    *g_name = (int*)malloc(sizeof(int) * argc),
    *g_wd = (int*)malloc(sizeof(int) * argc),
    *g_fd = (int*)malloc(sizeof(int) * argc);

  fd_set rfds;
  FD_ZERO(&rfds);

  for(ix = 0; ix < argc; ix++) {
    g_fd[ix] = inotify_init();
  }

  while(1) {
    fd = 0;

    for(ix = 1; ix < argc; ix++) {

      // Only add files to the watch that exist
      g_wd[fd] = inotify_add_watch( 
        g_fd[fd], argv[ix],
        ARGS
      );

      if(g_wd[fd] != -1) {
        g_name[fd] = ix;
        fd++;
      }
    }

    for(ix = 0; ix < fd; ix++) {
      FD_SET(g_fd[ix], &rfds);
    }

    select(g_fd[fd - 1] + 1, &rfds, NULL, NULL, NULL);
    printf("\n");
    system("date");

    for(ix = 0; ix < fd; ix++) {

      if(FD_ISSET(g_fd[ix], &rfds)) {
        len = read (g_fd[ix], buf, BUF_LEN);

        if (len > 0) {
          i = 0;
          while (i < len) {
            struct inotify_event *event;

            event = (struct inotify_event *) &buf[i];

            if (event->len) {
              printf ("%s ", event->name);
            }
            // Output type of access by using the map above
            for (iy = 0; iy < mapLen; iy++) {
              if(event->mask & map[iy].bit && map[iy].desc) {
                printf(" %s %s\n", argv[g_name[ix]], map[iy].desc);
              }
            }

            i += EVENT_SIZE + event->len;
          }
        }
      }
    } 

    fflush(0);
    FD_ZERO(&rfds);
  }

  free(g_fd);
  free(g_wd);

  return (!fd);
}
