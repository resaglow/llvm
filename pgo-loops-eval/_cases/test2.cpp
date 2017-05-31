const int N = 9999999;
int G[N];

__attribute__((noinline))
int fun1()
{
    int a = 3;
    return a;
}

__attribute__((noinline))
int fun2()
{
    int b = 7;
    return b;
}

__attribute__((noinline))
int example8(int x)
{;
    for (int i = 0; i < N; i++) {
        if (__builtin_expect(x == 5, 0)) {
            return fun1();
        } else if (__builtin_expect(x == 44, 0)) {
            return 444;
        } else {
            return fun2();
        }
    }
    return 55555;
}

int main()
{
    for (int i = 0; i < 1; i++)
    {
        int x = example8(5);
    }
}
