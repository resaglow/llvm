const int N = 9999999;
int G[N];
__attribute__((noinline))
void example8(int x)
{;
    for (int i = 0; i < N; i++) {
        if (__builtin_expect(x == 44, 0)) {
            G[i] = 22;
        } else if (__builtin_expect(x == 35, 0)) {
            G[i] = 86;
        } else if (__builtin_expect(x == 99, 0)) {
            G[i] = 33;
        } else if (__builtin_expect(x == 23, 0)) {
            G[i] = 13;
        } else if (__builtin_expect(x, 0)) {
            G[i] = 77;
        } else {
            G[i] = 11;
        }
    }
}

int main()
{
    for (int i = 0; i < 1; i++)
    {
        example8(5);
    }
}
