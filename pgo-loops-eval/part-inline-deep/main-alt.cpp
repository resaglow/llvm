#include <stdio.h>

int fun1(int *p)
{
	char condFun1 = 1;
	if (condFun1) {
		*p = 11;
	}

	return 1;
}

int fun2(int *p)
{
	char condFun2 = 0;
	if (condFun2) {
		*p = 12;
	}

	return 2;
}

int fun(int *p)
{
	char cond = 1;
	char cond2 = 0;
	if (cond) {
		int res;
		if (cond2) {
			res = fun1(p);
		} else {
			res = fun2(p);
		}
		return res;
	}

	return 0;
}

int dummyCaller(int *p)
{
	for (int i = 0; i < 100000000; i++)
	{
		fun(p);
	}

	return fun(p);
}

int main()
{
	int x;
	int res = dummyCaller(&x);
	printf("hello\n");
}
