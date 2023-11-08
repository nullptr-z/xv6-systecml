#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *args[])
{
  if (argc < 2)
  {
    printf("Usage: %s <argument>\n", args[0]);
    return -1;
  }

  int n = atoi(args[1]);
  sleep(n);
  printf("sleeping seconds: %d \n", n);

  return 0;
}
