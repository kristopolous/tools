#include <sys/inotify.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>

int main(int argc, char*argv[]) {
  int 
    ix,
    retval,
    * g_fd = (int*)malloc(sizeof(int) * argc);

  uint32_t * g_wd = (uint32_t*)malloc(sizeof(uint32_t) * argc);
  fd_set rfds;
  struct timeval tv;

  FD_ZERO(&rfds);

  argc--;
  argv++;

  if(argc) {
    for(ix = 0; ix < argc; ix++) {
      g_fd[ix] = inotify_init();

      g_wd[ix] = inotify_add_watch(
        g_fd[ix],
        argv[ix], 
        IN_ONESHOT | IN_MODIFY
      );

      FD_SET(g_fd[ix], &rfds);
    }

    retval = select(g_fd[ix - 1] + 1, &rfds, NULL, NULL, &tv);

    for(ix = 0; ix < argc; ix++) {
      inotify_rm_watch(g_fd[ix], g_wd[ix]);
    }
  }

  free(g_fd);
  free(g_wd);

  _exit (0);
}
