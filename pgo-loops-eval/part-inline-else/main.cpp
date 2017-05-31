#include <stdio.h>

int fun1(int *p)
{
  char condFun1 = 1;
  if (condFun1) {
    *p = 10;
    return 44;
  } else {
    *p = 13;
    return 55;
  }
}

// void fun2(int *p)
// {
//   char condFun2 = 0;
//   if (condFun2) {
//     *p = 12;
//   } else {
//     *p = 13;
//   }
// }

void dummyCaller(int *p)
{
  char cond = 0;
  char cond2 = 1;
  if (cond) {
    if (cond2) {
      fun1(p);
    }
  }
}

int main()
{
  int x;
  for (int i = 0; i < 100000000; i++)
  {
    dummyCaller(&x);
  }
  
  printf("hello\n");
}
