#include <sys/inotify.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

#include <sys/select.h>

/* size of the event structure, not counting name */
#define EVENT_SIZE  (sizeof (struct inotify_event))

/* reasonable guess as to size of 1024 events */
#define BUF_LEN        (1024 * (EVENT_SIZE + 16))

char buf[BUF_LEN];

// We listen for all the events and do so in a
// one shot way.  After we are done we can just
// reregister.
#define ARGS IN_ONESHOT | IN_MODIFY

// We create a map with the name of the bits
// mapped to the bitfields as specified in the 
// inotify man page.
//
// If you haven't seen anything like this, it will
// allow us to iterate through the array and test each
// bit.
//
// If it's successful, then we print out the desc. The
// code that does this is below.
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

// Since the control_c function is called on a signal,
// the easiest way to make the file descriptors accessible
// to the control_c function is to make them global.
//
// According to the man page of inotify_rm_watch, the watch
// descriptor should be a uint32_t, so it has been made so below.
int *g_fd;

uint32_t *g_wd;

void control_c(int ignored) {
  int ix;
  printf("Removing watch\n");

  for(ix = 0; g_fd[ix]; ix++) {
    inotify_rm_watch(g_fd[ix], g_wd[ix]);
  }

  free(g_fd);
  free(g_wd);

  _exit (0);
}

int main(int argc, char*argv[]){
  int ret,
      len,
      ix,
      i,
      mapLen = sizeof(map) / (sizeof(int) + sizeof(char*));

  fd_set rfds;
  struct timeval tv;
  int retval;

  FD_ZERO(&rfds);

  g_fd = (int*)malloc(sizeof(int) * argc);
  g_wd = (uint32_t*)malloc(sizeof(uint32_t) * argc);
  g_fd[argc - 1] = 0;

  // Since we block on a read, we need some other way of cleaning up
  // our watch when the user wants to exit.
  //
  // I usually just do control+c to exit my program, so we listen for 
  // that signal and we deregister the watch there.
  signal(SIGINT, control_c);

  argc--;
  argv++;
  for(ix = 0; ix < argc; ix++) {
    printf("Watching %s\n", argv[ix]);
    g_fd[ix] = inotify_init();

    g_wd[ix] = inotify_add_watch(g_fd[ix],
      argv[ix],
      ARGS);

    if (g_wd[ix] < 0) {
      perror ("inotify_add_watch");
    }

    FD_SET(g_fd[ix], &rfds);
  }

  retval = select(g_fd[ix - 1] + 1, &rfds, NULL, NULL, &tv);

  if(retval == -1) {
    perror("select()");
  } else {
    control_c(0);
  }
    /*
    len = read (g_fd, buf, BUF_LEN);

    if (len > 0) {
      i = 0;

      while (i < len) {
        struct inotify_event *event;

        event = (struct inotify_event *) &buf[i];

        if (event->len) {
          printf ("%s :: ", event->name);
        }

        // Output type of access by using the map above
        for (ix = 0; ix < mapLen; ix++) {
          if(event->mask & map[ix].bit) {
            if(map[ix].bit & (IN_CLOSE_NOWRITE|IN_CREATE|IN_OPEN)) {
              printf("%s :: (not running)\n", map[ix].desc);
            } else if(map[ix].desc) {
              printf("%s :: running %s\n", map[ix].desc, command);
              system(command);
            }
          }
        }

        i += EVENT_SIZE + event->len;
      }

      // Saving files at least in vim seems to temporarily remove
      // the file completely, and then write a new file with the
      // same name.
      // 
      // This means that there is some blackout period where the
      // file actually does not exist.  This little sleep here
      // is a naive way of avoiding this problem.  However, it
      // appears to work well.
      usleep(50000);

      // Since are ARGS specifies ONE_SHOT, we need to reregister
      // the watch each time.  This is fine.
      g_wd = inotify_add_watch(g_fd,
        file,
        ARGS);

      if (g_wd < 0) {
        perror ("inotify_add_watch");
      }

      fflush(0);
    }
  }*/
}
