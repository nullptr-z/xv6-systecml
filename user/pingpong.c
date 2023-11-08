#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define BUFFER_SIZE 50

int main(int argc, char *args[])
{
  char buff[BUFFER_SIZE];
  int p[2];

  if (pipe(p) < 0)
    exit(1);

  if (fork() == 0)
  {
    read(p[0], buff, BUFFER_SIZE);
    // printf("<%d> child receiver: %s \n", getpid(), buff);
    printf("%d: received ping\n", getpid());
    char *c = "I is child for you";
    write(p[1], c, strlen(c));
    exit(1);
  }
  else
  {
    char *c = "im you father";
    write(p[1], c, strlen(c));
    read(p[0], buff, BUFFER_SIZE);
    // printf("<%d> parent receiver: %s \n", getpid(), buff);
    printf("%d: received pong\n", getpid());
    exit(1);
  }

  return 0;
}
