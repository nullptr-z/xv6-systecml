
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

int main(int argc, char *args[])
{
  if (argc < 2)
  {
    printf("less than 2 parameters");
    return -1;
  }
  printf("args[2] %s", args[2]);

  char *path = args[1];
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if ((fd = open(path, 0)) < 0)
  {
    fprintf(2, "find: cannot open %s\n", path);
    return -1;
  }

  if (fstat(fd, &st) < 0)
  {
    fprintf(2, "find: cannot stat %s\n", path);
    close(fd);
    return -1;
  }

  switch (st.type)
  {
  case T_DIR:
    if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf)
    {
      printf("ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf + strlen(buf);
    *p++ = '/';
    while (read(fd, &de, sizeof(de)) == sizeof(de))
    {
      if (de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if (stat(buf, &st) < 0)
      {
        printf("ls: cannot stat %s\n", buf);
        continue;
      }
      char *c = args[2];
      strcpy(c, path);

      int q = strcmp(buf, c);
      printf("compare: %s  %d\n", c, q);
      if (q > 0)
      {
        printf("file: %s  %d\n", buf, q);
      }
    }
    break;

  default:
    fprintf(2, "find: file type does not exist %s\n", path);
    break;
  }

  return 0;
}
