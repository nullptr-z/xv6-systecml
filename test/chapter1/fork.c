int main()
{
  int pid = fork();
  if (pid > 0)
  {
    printf("the is child:=%d\n", pid);
    pid = wait((int *)0);
    printf("child:=%d is done\n", pid);
  }
  else if (pid == 0)
  {
    printf("this parent,child: exiting\n");
    exit(0);
  }
  else
  {
    printf("fork error\n");
  }
}
