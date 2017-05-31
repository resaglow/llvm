#include <stdio.h>

int fun1(bool cond, int *p)
{
	if (cond) {
		*p = 11;
	}

	return 1;
}

int fun2(bool cond, int *p)
{
	if (cond) {
		*p = 12;
	}

	return 2;
}

int fun(bool cond, int *p)
{
	if (cond) {
		int res;
		if (cond) {
			res = fun1(cond, p);
		} else {
			res = fun2(cond, p);
		}
		return res;
	}

	return 0;
}

int dummyCaller(bool cond, int *p)
{
	for (int i = 0; i < 100000000; i++) {
		fun(cond, p);
	}

	return fun(cond, p);
}

int main()
{
	int x;
	int res = dummyCaller(true, &x);
	printf("hello\n");
}
