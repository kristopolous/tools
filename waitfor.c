#include <stdio.h>
#include <stdlib.h>
#include <sys/inotify.h>
#include <sys/select.h>

int main(int argc, char*argv[]) {
  int 
    fd = 0,
    * g_wd = (int*)malloc(sizeof(int) * argc),
    * g_fd = (int*)malloc(sizeof(int) * argc);

  fd_set rfds;
  struct timeval tv;

  FD_ZERO(&rfds);

  g_fd[fd] = inotify_init();

  for(argc--, argv++; argc; argc--, argv++) {

    // Only add files to the watch that exist
    g_wd[fd] = inotify_add_watch(
      g_fd[fd],

      *argv,

      IN_ONESHOT     | IN_MOVE_SELF  | 
      IN_MODIFY      | IN_CREATE     | 
      IN_CLOSE_WRITE | IN_DELETE_SELF
    );

    if(g_wd[fd] != -1) {
      FD_SET(g_fd[fd], &rfds);
      fd++;

      g_fd[fd] = inotify_init();
      fprintf(stderr, "%s ", *argv);
    }
  }

  if(fd) {
    fprintf(stderr, "\n");
    select(g_fd[fd - 1] + 1, &rfds, NULL, NULL, &tv);

    do {
      inotify_rm_watch(g_fd[fd], g_wd[fd]);
    } while(fd--);

    fd = 1;
  }

  free(g_fd);
  free(g_wd);

  return (!fd);
}
