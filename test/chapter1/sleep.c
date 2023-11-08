int main(int argc, char *args[])
{
  if (argc < 2)
  {
    printf("Usage: %s <argument>\n", args[0]);
    return -1;
  }

  int n = atoi(args[1]);
  printf("sleeping seconds: %d \n", n);
  sleep(n);

  return 0;
}
