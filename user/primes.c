
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define RD 0
#define WR 1
#define NUMS_LIMIT 35

void primes(int pp[2], int len);

int main(int argc, char *args[])
{
  int pp[2];
  pipe(pp);
  for (int i = 2; i <= NUMS_LIMIT; i++)
  {
    write(pp[WR], &i, sizeof(int));
  }

  if (fork() == 0)
  {
    primes(pp, NUMS_LIMIT - 1);
  }
  else
  {
    wait(0);
    close(pp[0]);
    close(pp[1]);
  }

  exit(0);
}

int count = 0;
void primes(int pp[2], int len)
{
  int nums[len];
  read(pp[RD], nums, len * sizeof(int));

  if (nums[count] >= NUMS_LIMIT)
  {
    for (int i = 0; i < len; i++)
    {
      printf("prime %d\n", nums[i]);
    }

    exit(0);
  }

  int r = nums[count];
  int n = 0;
  for (int i = 0; i < len; i++)
  {
    if (nums[i] % r != 0 || nums[i] == r)
    {
      n++;
      write(pp[WR], &nums[i], sizeof(int));
    }
  }

  count++;
  primes(pp, n);
  exit(0);
}

// prime: 2
// prime: 3
// prime: 5
// prime: 7
// prime: 11
// prime: 13
// prime: 17
// prime: 19
// prime: 23
// prime: 29
// prime: 31
