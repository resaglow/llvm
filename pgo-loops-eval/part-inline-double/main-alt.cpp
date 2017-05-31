// For some reason the partial-inlined version was worse with returns (of some arbitrary numbers) everywhere.
// TODO Figure out why

#include <stdio.h>

void fun1(int *p)
{
	char condFun1 = 1;
	if (condFun1) {
		*p = 11;
	}
}

void fun2(int *p)
{
	char condFun2 = 0;
	if (condFun2) {
		*p = 12;
	}
}

void fun(int *p)
{
	char cond = 0;
	char cond2 = 1;
	int res = 99;
	if (cond) {
		if (cond2) {
			fun1(p);
		}
	}
}

void dummyCaller(int *p)
{
	fun(p);
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
