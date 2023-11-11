#include "kernel/types.h"
#include "kernel/fs.h"
#include "kernel/param.h"
#include "user/user.h"

#define STDIN_ARGS_LEN 50

int main(int argc, char *args[])
{
  sleep(10);

  char stdin_args[STDIN_ARGS_LEN];
  read(0, stdin_args, STDIN_ARGS_LEN);
  // printf("stdin_args: %s\n", stdin_args);

  // 不建议直接使用args,因为它的内存空间已经确定了，强行使用它后果是未知的
  char *v_args[MAXARG];
  int v_cnt = 0;
  for (int i = 1; i < argc; i++, v_cnt++)
  {
    v_args[v_cnt] = args[i];
  }
  // for (int j = 0; j < v_cnt; j++)
  // {
  //   printf("command: %s\n", v_args[j]);
  // }

  char *extr = stdin_args;
  for (int i = 0; i < STDIN_ARGS_LEN; i++)
  {
    if (stdin_args[i] == '\n')
    {
      if (fork() > 0)
      {
        extr = &stdin_args[i + 1];
        wait(0);
      }
      else
      {
        // the children
        stdin_args[i] = 0;
        v_args[v_cnt] = extr;
        v_cnt++;
        v_args[v_cnt] = 0;
        v_cnt++;

        exec(args[1], v_args);
        exit(0);
      }
    }
  }

  wait(0);
  exit(0);
}
